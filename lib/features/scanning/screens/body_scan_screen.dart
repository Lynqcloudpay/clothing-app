import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/routes/app_router.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_typography.dart';
import '../../../core/models/body_scan_session.dart';
import '../../../core/providers/scan_provider.dart';
import '../../../core/services/body_framing_analyzer.dart';
import '../../../core/services/body_measurement_engine.dart';
import '../../../core/services/pose_frame_processor.dart';
import '../../../core/services/vision_bridge.dart';
import '../widgets/live_camera_preview.dart';
import '../widgets/live_measurement_overlay.dart';

/// Real-time body scan driven by actual camera frames.
///
/// Mobile (Android/iOS): every camera frame goes through ML Kit pose
/// detection ([PoseFrameProcessor]); landmark geometry is calibrated to
/// centimeters with the user's real height. Web: frames are analyzed by
/// the JavaScript contour bridge (`web/body_vision.js`).
///
/// Nothing here is timer-fabricated: confidence comes from landmark
/// likelihoods, measurements come from landmark geometry, and auto-capture
/// only fires after the pose is genuinely stable.
class BodyScanScreen extends ConsumerStatefulWidget {
  const BodyScanScreen({super.key});

  @override
  ConsumerState<BodyScanScreen> createState() => _BodyScanScreenState();
}

class _BodyScanScreenState extends ConsumerState<BodyScanScreen>
    with SingleTickerProviderStateMixin {
  final BodyFramingAnalyzer _analyzer = BodyFramingAnalyzer();
  final PoseFrameProcessor _processor = PoseFrameProcessor();

  ScanAngle _currentAngle = ScanAngle.front;

  // Live camera plumbing
  CameraController? _cameraController;
  CameraDescription? _cameraDescription;
  DeviceOrientation _deviceOrientation = DeviceOrientation.portraitUp;
  bool _streaming = false;
  Timer? _webVisionTimer;

  // Real-time analysis state
  FrameAnalysisResult? _analysisResult;
  PoseBodyMetrics? _lastMetrics;

  // Freshness tracking: measurements older than this are stale and must
  // never be captured. processFrame returns null both when throttled/busy
  // and when nobody is in frame, so staleness is time-based, not per-frame.
  DateTime? _lastFreshFrameTime;
  static const Duration _staleThreshold = Duration(seconds: 2);

  /// True only when the current measurements come from a recent frame.
  bool get _hasFreshData {
    final t = _lastFreshFrameTime;
    return t != null && DateTime.now().difference(t) <= _staleThreshold;
  }

  double _confidence = 0.0;
  String _statusMessage = 'POSITION BODY IN FRAME';
  bool _isLockedAndCapturing = false;

  // Hands-free auto-capture: the pose must stay good for this long.
  double _stableHoldSeconds = 0.0;
  static const double _autoCaptureHoldSeconds = 3.0;

  /// Front-view shoulder separation, used to detect the 90° turn in the
  /// side view (the shoulders compress horizontally when sideways).
  double? _frontShoulderSeparationPx;

  // Captured measurements per angle — real camera data only.
  final Map<String, double> _frontMeasurements = {};
  final Map<String, double> _sideMeasurements = {};
  final Map<String, double> _backMeasurements = {};

  // Scanning sweep line animation
  late final AnimationController _scannerAnimController;

  @override
  void initState() {
    super.initState();
    ref.read(scanSessionProvider.notifier).updateStatus(ScanStatus.scanning);

    _scannerAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    // Web has no CameraImage stream — poll the JS vision bridge instead.
    if (kIsWeb) {
      _webVisionTimer = Timer.periodic(
        const Duration(milliseconds: 150),
        (_) => _pollWebVision(),
      );
    }
  }

  @override
  void dispose() {
    _webVisionTimer?.cancel();
    _stopImageStream();
    _processor.dispose();
    _scannerAnimController.dispose();
    super.dispose();
  }

  // ── Camera plumbing ──────────────────────────────────────────────

  void _onCameraReady(CameraController controller) {
    _cameraController = controller;
    _cameraDescription = controller.description;
    _deviceOrientation = _currentDeviceOrientation();
    _startImageStream();
  }

  void _onCameraDisposing() {
    _stopImageStream();
    _cameraController = null;
    _cameraDescription = null;
  }

  DeviceOrientation _currentDeviceOrientation() {
    final size = MediaQuery.maybeOf(context)?.size;
    if (size != null && size.width > size.height) {
      return DeviceOrientation.landscapeLeft;
    }
    return DeviceOrientation.portraitUp;
  }

  Future<void> _startImageStream() async {
    final controller = _cameraController;
    if (controller == null || _streaming || kIsWeb) return;
    _streaming = true;
    try {
      await controller.startImageStream(_onCameraFrame);
    } catch (_) {
      _streaming = false;
    }
  }

  Future<void> _stopImageStream() async {
    if (!_streaming) return;
    _streaming = false;
    try {
      await _cameraController?.stopImageStream();
    } catch (_) {
      // Controller may already be gone — nothing to stop.
    }
  }

  // ── Frame analysis ───────────────────────────────────────────────

  Future<void> _onCameraFrame(CameraImage image) async {
    if (!mounted || _isLockedAndCapturing) return;
    final description = _cameraDescription;
    if (description == null) return;

    final heightCm = ref.read(userHeightCmProvider);
    final metrics = await _processor.processFrame(
      image,
      description,
      _deviceOrientation,
      heightCm: heightCm,
      referenceShoulderPx: _frontShoulderSeparationPx,
      mirrorHorizontally:
          description.lensDirection == CameraLensDirection.front,
    );
    // Null ⇒ throttled, busy, or no person in frame. Throttled frames are
    // harmless, but if no fresh frame has arrived within the staleness
    // window the person is gone: clear the UI instead of freezing on
    // stale measurements.
    if (metrics == null || !mounted) {
      _handlePotentiallyStaleFrame();
      return;
    }
    _lastFreshFrameTime = DateTime.now();

    final result = _analyzer.analyzeLivePose(
      metrics: metrics,
      currentAngleIndex: _currentAngle.index,
    );
    _handleAnalysisResult(result, metrics, holdIncrement: 0.125);
  }

  /// Web fallback: no CameraImage stream, so poll the JS contour bridge.
  /// The user's height is pushed on every poll (cheap, idempotent) so the
  /// bridge can calibrate pixels to centimeters even if it loaded late.
  void _pollWebVision() {
    if (!mounted || _isLockedAndCapturing) return;
    setWebVisionHeightCm(ref.read(userHeightCmProvider));
    final result = _analyzer.analyzeLivePose(
      metrics: null,
      currentAngleIndex: _currentAngle.index,
    );
    if (result.detectedMeasurements.isNotEmpty) {
      _lastFreshFrameTime = DateTime.now();
    }
    _handleAnalysisResult(result, null, holdIncrement: 0.15);
  }

  /// Pushes an explicit no-person state once vision data goes stale, so a
  /// manual capture can never accept frozen measurements.
  void _handlePotentiallyStaleFrame() {
    final lastFresh = _lastFreshFrameTime;
    if (lastFresh == null) return; // never had a reading — nothing to clear
    if (DateTime.now().difference(lastFresh) <= _staleThreshold) return;
    _lastMetrics = null;
    _stableHoldSeconds = 0.0;
    _handleAnalysisResult(
      _analyzer.noPersonResult(),
      null,
      holdIncrement: 0,
    );
  }

  void _handleAnalysisResult(
    FrameAnalysisResult result,
    PoseBodyMetrics? metrics, {
    required double holdIncrement,
  }) {
    final ready = _readyForCapture(result, metrics);
    if (ready) {
      _stableHoldSeconds += holdIncrement;
    } else {
      _stableHoldSeconds = 0.0;
    }

    final remaining =
        (_autoCaptureHoldSeconds - _stableHoldSeconds).clamp(0.0, 3.0);

    setState(() {
      _analysisResult = result;
      _lastMetrics = metrics;
      _confidence = result.confidence;
      _statusMessage = ready
          ? 'HOLD STEADY: ${remaining.ceil()}s TO AUTO-CAPTURE (OR TAP BUTTON)'
          : result.statusMessage;
    });

    if (_stableHoldSeconds >= _autoCaptureHoldSeconds) {
      _stableHoldSeconds = 0.0;
      _onCaptureTriggered();
    }
  }

  /// Auto-capture requires a genuinely good pose: full body in frame and a
  /// stable (non-jittery) landmark track. The side view additionally
  /// requires an actual 90° turn once we have a front reference.
  bool _readyForCapture(FrameAnalysisResult result, PoseBodyMetrics? metrics) {
    if (!result.hasFullBody) return false;
    if (metrics != null) {
      if (!_processor.isStable) return false;
      if (_currentAngle == ScanAngle.side &&
          _frontShoulderSeparationPx != null &&
          !metrics.looksSideways) {
        return false;
      }
      return true;
    }
    // Web: stability comes from the bridge's own confidence smoothing.
    return result.confidence >= 0.75;
  }

  // ── Capture flow ─────────────────────────────────────────────────

  void _onCaptureTriggered() {
    if (_isLockedAndCapturing) return;
    final result = _analysisResult;
    if (result == null || result.detectedMeasurements.isEmpty) {
      _showBannerNotification('NO BODY DETECTED — POSITION YOURSELF IN FRAME');
      return;
    }
    // Never capture frozen data: the reading must come from a recent frame.
    if (!_hasFreshData) {
      _showBannerNotification('HOLD STILL — WAITING FOR A CLEAR READING');
      return;
    }
    // Manual capture enforces the same validity as auto-capture: full body
    // in frame, stable track, and the correct orientation for the angle.
    if (!_readyForCapture(result, _lastMetrics)) {
      _showBannerNotification(result.statusMessage);
      return;
    }

    _isLockedAndCapturing = true;
    setState(() {
      _confidence = 1.0;
      _statusMessage = '100% CAPTURED!';
    });

    // Shutter flash duration, then advance to the next angle.
    Future.delayed(const Duration(milliseconds: 350), () {
      if (!mounted) return;
      _advanceAngle();
    });
  }

  /// Widths captured for a front/back view, from real pose geometry.
  Map<String, double>? _capturedWidths(
      FrameAnalysisResult result, PoseBodyMetrics? metrics) {
    if (metrics != null) {
      return {
        'shoulder': metrics.shoulderWidthCm,
        'chest': metrics.chestWidthCm,
        'waist': metrics.waistWidthCm,
        'hips': metrics.hipsWidthCm,
      };
    }
    final m = result.detectedMeasurements;
    if (!['shoulder', 'chest', 'waist', 'hips']
        .every((k) => m.containsKey(k))) {
      return null;
    }
    return {
      'shoulder': m['shoulder']!,
      'chest': m['chest']!,
      'waist': m['waist']!,
      'hips': m['hips']!,
    };
  }

  /// Torso depths captured for the side view, from real pose geometry.
  Map<String, double>? _capturedDepths(
      FrameAnalysisResult result, PoseBodyMetrics? metrics) {
    if (metrics != null) {
      return {
        'chest': metrics.sideChestDepthCm,
        'waist': metrics.sideWaistDepthCm,
      };
    }
    return result.sideDepths;
  }

  void _advanceAngle() {
    final result = _analysisResult;
    final metrics = _lastMetrics;

    if (_currentAngle == ScanAngle.front) {
      final widths = result == null ? null : _capturedWidths(result, metrics);
      if (widths == null) {
        return _abortCapture('FRONT CAPTURE FAILED — TRY AGAIN');
      }
      _frontMeasurements
        ..clear()
        ..addAll(widths);
      if (metrics != null) {
        _frontShoulderSeparationPx = metrics.shoulderSeparationPx;
      }
      ref.read(scanSessionProvider.notifier).updateProgress(0.33);

      setState(() {
        _currentAngle = ScanAngle.side;
        _isLockedAndCapturing = false;
        _stableHoldSeconds = 0.0;
      });
      _processor.resetStability();

      _showBannerNotification(
          'FRONT VIEW SAVED (CHEST: ${widths['chest']!.toStringAsFixed(1)} cm)\nNOW TURN 90° TO YOUR SIDE');
    } else if (_currentAngle == ScanAngle.side) {
      final depths = result == null ? null : _capturedDepths(result, metrics);
      if (depths == null ||
          !depths.containsKey('chest') ||
          !depths.containsKey('waist')) {
        return _abortCapture('SIDE CAPTURE FAILED — TRY AGAIN');
      }
      _sideMeasurements
        ..clear()
        ..addAll(depths);
      ref.read(scanSessionProvider.notifier).updateProgress(0.66);

      setState(() {
        _currentAngle = ScanAngle.back;
        _isLockedAndCapturing = false;
        _stableHoldSeconds = 0.0;
      });
      _processor.resetStability();

      _showBannerNotification(
          'SIDE PROFILE SAVED (DEPTH: ${depths['chest']!.toStringAsFixed(1)} cm)\nNOW TURN TO YOUR BACK');
    } else {
      final widths = result == null ? null : _capturedWidths(result, metrics);
      if (widths == null) {
        return _abortCapture('BACK CAPTURE FAILED — TRY AGAIN');
      }
      _backMeasurements
        ..clear()
        ..addAll(widths);
      ref.read(scanSessionProvider.notifier).updateProgress(1.0);

      _webVisionTimer?.cancel();
      _finishScanningPipeline();
    }
  }

  void _abortCapture(String message) {
    _showBannerNotification(message);
    setState(() {
      _isLockedAndCapturing = false;
      _stableHoldSeconds = 0.0;
    });
  }

  void _showBannerNotification(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        backgroundColor: AppColors.primaryGold,
        duration: const Duration(milliseconds: 2500),
      ),
    );
  }

  void _finishScanningPipeline() {
    ref.read(scanSessionProvider.notifier).updateStatus(ScanStatus.processing);

    // Every angle must have produced real data — no canned fallbacks.
    final missing = ['shoulder', 'chest', 'waist', 'hips'].any((k) =>
            _frontMeasurements[k] == null || _backMeasurements[k] == null) ||
        _sideMeasurements['chest'] == null ||
        _sideMeasurements['waist'] == null;
    if (missing) {
      ref.read(scanSessionProvider.notifier).updateStatus(ScanStatus.scanning);
      _showBannerNotification('CAPTURE INCOMPLETE — PLEASE RESCAN');
      setState(() {
        _currentAngle = ScanAngle.front;
        _isLockedAndCapturing = false;
      });
      return;
    }

    // Front and back widths are averaged for robustness; side depths turn
    // the widths into true circumferences via the ellipse model.
    double avg(String key) =>
        (_frontMeasurements[key]! + _backMeasurements[key]!) / 2;

    final measurements = BodyMeasurementEngine.computeFromMultiAngle(
      heightCm: ref.read(userHeightCmProvider),
      frontShoulderWidth: avg('shoulder'),
      frontChestWidth: avg('chest'),
      frontWaistWidth: avg('waist'),
      frontHipsWidth: avg('hips'),
      sideChestDepth: _sideMeasurements['chest']!,
      sideWaistDepth: _sideMeasurements['waist']!,
    );

    ref.read(scanSessionProvider.notifier).setMeasurements(measurements);
    ref.read(scanSessionProvider.notifier).updateStatus(ScanStatus.completed);

    if (mounted) {
      context.go(RoutePaths.scanResults);
    }
  }

  String get _currentAngleText {
    switch (_currentAngle) {
      case ScanAngle.front:
        return '1/3: FRONT VIEW (A-POSE)';
      case ScanAngle.side:
        return '2/3: SIDE PROFILE (90°)';
      case ScanAngle.back:
        return '3/3: BACK CONTOUR (180°)';
    }
  }

  String get _captureButtonText {
    switch (_currentAngle) {
      case ScanAngle.front:
        return 'CAPTURE FRONT POSE';
      case ScanAngle.side:
        return 'CAPTURE SIDE PROFILE';
      case ScanAngle.back:
        return 'CAPTURE BACK CONTOUR';
    }
  }

  @override
  Widget build(BuildContext context) {
    final confidencePct = (_confidence * 100).toInt();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Live Camera Stream (Wide-Angle Full View)
          LiveCameraPreview(
            onCameraReady: _onCameraReady,
            onCameraDisposing: _onCameraDisposing,
          ),

          // 2. High-Tech Animated Scanning Laser Beam
          AnimatedBuilder(
            animation: _scannerAnimController,
            builder: (context, child) {
              return CustomPaint(
                painter:
                    _LaserScanPainter(progress: _scannerAnimController.value),
              );
            },
          ),

          // 3. Real-Time Dynamic Measurement Calipers Over Body
          IgnorePointer(
            child: LiveMeasurementOverlay(
              currentAngle: _currentAngle,
              userHeightCm: ref.watch(userHeightCmProvider),
              analysisResult: _analysisResult,
            ),
          ),

          // 4. Unified AI Top HUD
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Step Badge & Status Pill
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.85),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: AppColors.primaryGold, width: 1.2),
                        ),
                        child: Text(
                          _currentAngleText,
                          style: const TextStyle(
                            color: AppColors.primaryGold,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),

                      // Status Pill
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 7),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.greenAccent),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Colors.greenAccent,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'MEASURING CONTOURS',
                              style: TextStyle(
                                color: Colors.greenAccent,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // AI Confidence Progress Bar
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'AI BODY CONFIDENCE',
                              style: AppTypography.labelSmall.copyWith(
                                color: Colors.white70,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '$confidencePct%',
                              style: const TextStyle(
                                color: AppColors.primaryGold,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: _confidence,
                            minHeight: 6,
                            backgroundColor: Colors.white10,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                AppColors.primaryGold),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Real-Time Guidance & Hold Banner
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: AppColors.primaryGold.withValues(alpha: 0.6),
                          width: 1.2),
                    ),
                    child: Text(
                      _statusMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 5. Close Button
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              onPressed: () => context.pop(),
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close_rounded,
                    color: Colors.white, size: 24),
              ),
            ),
          ),

          // 6. Prominent Gold Capture Action Button (Instant Manual Trigger)
          Positioned(
            bottom: 28,
            left: 20,
            right: 20,
            child: SafeArea(
              child: ElevatedButton.icon(
                onPressed: _isLockedAndCapturing ? null : _onCaptureTriggered,
                icon: Icon(
                  _currentAngle == ScanAngle.front
                      ? Icons.camera_alt_rounded
                      : (_currentAngle == ScanAngle.side
                          ? Icons.rotate_right_rounded
                          : Icons.check_circle_rounded),
                  size: 22,
                ),
                label: Text(
                  _captureButtonText,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      letterSpacing: 0.8),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGold,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 6,
                ),
              ),
            ),
          ),

          // 7. Visual Camera Flash on Capture
          if (_isLockedAndCapturing)
            Container(
              color: Colors.white.withValues(alpha: 0.92),
            ),
        ],
      ),
    );
  }
}

class _LaserScanPainter extends CustomPainter {
  final double progress;

  _LaserScanPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final y = (0.18 + (progress * 0.58)) * size.height;

    final beamPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.transparent,
          AppColors.primaryGold.withValues(alpha: 0.8),
          Colors.cyanAccent.withValues(alpha: 0.9),
          AppColors.primaryGold.withValues(alpha: 0.8),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, y, size.width, 3));

    canvas.drawRect(Rect.fromLTWH(0, y - 1, size.width, 3), beamPaint);
  }

  @override
  bool shouldRepaint(covariant _LaserScanPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
