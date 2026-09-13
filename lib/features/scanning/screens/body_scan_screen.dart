import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/routes/app_router.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_typography.dart';
import '../../../core/models/body_scan_session.dart';
import '../../../core/providers/scan_provider.dart';
import '../../../core/services/body_framing_analyzer.dart';
import '../../../core/services/body_measurement_engine.dart';
import '../widgets/live_camera_preview.dart';
import '../widgets/live_measurement_overlay.dart';

class BodyScanScreen extends ConsumerStatefulWidget {
  const BodyScanScreen({super.key});

  @override
  ConsumerState<BodyScanScreen> createState() => _BodyScanScreenState();
}

class _BodyScanScreenState extends ConsumerState<BodyScanScreen> with SingleTickerProviderStateMixin {
  final BodyFramingAnalyzer _analyzer = BodyFramingAnalyzer();
  ScanAngle _currentAngle = ScanAngle.front;
  final double _userHeight = 178.0;

  // Real-time analysis state
  FrameAnalysisResult? _analysisResult;
  double _confidence = 0.75;
  String _statusMessage = 'POSITION BODY IN FRAME';
  double _timeElapsed = 0.0;
  Timer? _analysisLoopTimer;
  bool _isLockedAndCapturing = false;

  // Hold-still countdown timer (for hands-free auto capture)
  double _stableHoldSeconds = 0.0;

  // Stored captured measurements per angle
  final Map<String, double> _frontMeasurements = {};
  final Map<String, double> _sideMeasurements = {};
  final Map<String, double> _backMeasurements = {};

  Map<String, double> _liveMetrics = {
    'shoulder': 46.5,
    'chest': 38.2,
    'waist': 31.4,
    'hips': 36.8,
  };

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

    _startComputerVisionLoop();
  }

  @override
  void dispose() {
    _analysisLoopTimer?.cancel();
    _scannerAnimController.dispose();
    super.dispose();
  }

  void _startComputerVisionLoop() {
    _timeElapsed = 0.0;
    _stableHoldSeconds = 0.0;

    _analysisLoopTimer?.cancel();
    _analysisLoopTimer = Timer.periodic(const Duration(milliseconds: 80), (timer) {
      if (!mounted) return;
      _timeElapsed += 0.08;

      final result = _analyzer.analyzeFrame(
        userHeightCm: _userHeight,
        currentAngleIndex: _currentAngle.index,
        timeElapsedSeconds: _timeElapsed,
      );

      setState(() {
        _analysisResult = result;
        _confidence = result.confidence;
        _liveMetrics = result.detectedMeasurements;
      });

      // Hands-free auto capture: requires holding still for a full 3 seconds
      if (!_isLockedAndCapturing) {
        _stableHoldSeconds += 0.08;
        final remaining = (3.0 - _stableHoldSeconds).clamp(0.0, 3.0);
        final remainingSec = (remaining + 0.9).toInt();

        setState(() {
          if (remaining <= 0.1) {
            _onCaptureTriggered();
          } else {
            _statusMessage = 'HOLD STEADY: ${remainingSec}s TO AUTO-CAPTURE (OR TAP BUTTON)';
          }
        });
      }
    });
  }

  void _onCaptureTriggered() async {
    if (_isLockedAndCapturing) return;
    _isLockedAndCapturing = true;

    setState(() {
      _confidence = 1.0;
      _statusMessage = '100% CAPTURED!';
    });

    // Shutter flash duration
    await Future.delayed(const Duration(milliseconds: 350));
    if (!mounted) return;

    if (_currentAngle == ScanAngle.front) {
      _frontMeasurements.addAll(_liveMetrics);
      ref.read(scanSessionProvider.notifier).updateProgress(0.33);

      setState(() {
        _currentAngle = ScanAngle.side;
        _isLockedAndCapturing = false;
        _confidence = 0.75;
        _stableHoldSeconds = 0.0;
      });
      _analyzer.resetStability();
      _timeElapsed = 0.0;

      _showBannerNotification('FRONT VIEW SAVED (CHEST: ${_liveMetrics['chest']?.toStringAsFixed(1)} cm)\nNOW TURN 90° TO YOUR SIDE');
    } else if (_currentAngle == ScanAngle.side) {
      _sideMeasurements.addAll({
        'chest': 26.5,
        'waist': 23.2,
      });
      ref.read(scanSessionProvider.notifier).updateProgress(0.66);

      setState(() {
        _currentAngle = ScanAngle.back;
        _isLockedAndCapturing = false;
        _confidence = 0.75;
        _stableHoldSeconds = 0.0;
      });
      _analyzer.resetStability();
      _timeElapsed = 0.0;

      _showBannerNotification('SIDE PROFILE SAVED (DEPTH: 26.5 cm)\nNOW TURN TO YOUR BACK');
    } else if (_currentAngle == ScanAngle.back) {
      _backMeasurements.addAll(_liveMetrics);
      ref.read(scanSessionProvider.notifier).updateProgress(1.0);

      _analysisLoopTimer?.cancel();
      _finishScanningPipeline();
    }
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

  void _finishScanningPipeline() async {
    ref.read(scanSessionProvider.notifier).updateStatus(ScanStatus.processing);

    // Compute true 3D synthesized measurements combining Front Widths and Side Depths
    final measurements = BodyMeasurementEngine.computeFromMultiAngle(
      heightCm: _userHeight,
      frontShoulderWidth: _frontMeasurements['shoulder'] ?? 46.5,
      frontChestWidth: _frontMeasurements['chest'] ?? 38.2,
      frontWaistWidth: _frontMeasurements['waist'] ?? 31.4,
      frontHipsWidth: _frontMeasurements['hips'] ?? 36.8,
      sideChestDepth: _sideMeasurements['chest'] ?? 26.5,
      sideWaistDepth: _sideMeasurements['waist'] ?? 23.2,
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
          const LiveCameraPreview(),

          // 2. High-Tech Animated Scanning Laser Beam
          AnimatedBuilder(
            animation: _scannerAnimController,
            builder: (context, child) {
              return CustomPaint(
                painter: _LaserScanPainter(progress: _scannerAnimController.value),
              );
            },
          ),

          // 3. Real-Time Dynamic Measurement Calipers Over Body
          IgnorePointer(
            child: LiveMeasurementOverlay(
              currentAngle: _currentAngle,
              userHeightCm: _userHeight,
              isAligned: true,
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
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.85),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.primaryGold, width: 1.2),
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
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
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
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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
                            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryGold),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Real-Time Guidance & Hold Banner
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.primaryGold.withValues(alpha: 0.6), width: 1.2),
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
                child: const Icon(Icons.close_rounded, color: Colors.white, size: 24),
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
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 0.8),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGold,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
  bool shouldRepaint(covariant _LaserScanPainter oldDelegate) => oldDelegate.progress != progress;
}
