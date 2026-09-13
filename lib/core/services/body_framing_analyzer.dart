import 'dart:convert';
import 'dart:math' as math;
import 'pose_frame_processor.dart';
import 'vision_bridge.dart';

/// Dynamic landmark caliper span for a specific body contour line
class CaliperSpan {
  final double yRatio; // Vertical placement (0.0 top to 1.0 bottom)
  final double leftXRatio; // Left point (0.0 to 1.0)
  final double rightXRatio; // Right point (0.0 to 1.0)
  final double valueCm; // Dynamic measurement in cm
  final bool isVisible;

  const CaliperSpan({
    required this.yRatio,
    required this.leftXRatio,
    required this.rightXRatio,
    required this.valueCm,
    this.isVisible = true,
  });

  double get widthRatio => (rightXRatio - leftXRatio).abs();
  double get centerXRatio => (leftXRatio + rightXRatio) / 2.0;
}

/// Computer Vision Frame Analysis Result with Live Dynamic Landmarking
class FrameAnalysisResult {
  final double confidence; // 0.0 to 1.0
  final bool hasFullBody;
  final bool isTooClose;
  final bool isCutOffTop;
  final bool isCutOffBottom;
  final String statusMessage;
  final CaliperSpan shoulder;
  final CaliperSpan chest;
  final CaliperSpan waist;
  final CaliperSpan hips;
  final double? headYRatio;
  final double? feetYRatio;
  final double centerXRatio;

  /// Full front widths in centimeters (shoulder/chest/waist/hips).
  /// Unit contract: these are FULL widths, never half-widths and never
  /// circumferences. [BodyMeasurementEngine] converts widths → circumferences.
  /// Only genuinely detected values appear here — estimates and heuristics
  /// (e.g. inseam from height) do not belong in this map.
  final Map<String, double> detectedMeasurements;

  /// Front-to-back torso depths in centimeters, meaningful in the side view.
  /// Keys: 'chest', 'waist'. On mobile these come from the side-view pose
  /// geometry; on web from the JS contour bridge (whose contour width in a
  /// side view is already the depth).
  final Map<String, double>? sideDepths;

  const FrameAnalysisResult({
    required this.confidence,
    required this.hasFullBody,
    required this.isTooClose,
    required this.isCutOffTop,
    required this.isCutOffBottom,
    required this.statusMessage,
    required this.shoulder,
    required this.chest,
    required this.waist,
    required this.hips,
    this.headYRatio,
    this.feetYRatio,
    required this.centerXRatio,
    required this.detectedMeasurements,
    this.sideDepths,
  });
}

/// Real-time body framing analysis driven by actual vision data.
///
/// Two sources, both real:
/// - Mobile (Android/iOS): [PoseBodyMetrics] from ML Kit pose detection,
///   produced per camera frame by [PoseFrameProcessor].
/// - Web: contour data from the JavaScript edge-detection bridge
///   (`web/body_vision.js`), which reads real `<video>` pixels.
///
/// There is no synthetic fallback: when no person is detected the result
/// says so explicitly instead of fabricating confidence.
class BodyFramingAnalyzer {
  // Smoothing filter for the web vision path (EMA to kill frame jitter).
  double _smoothShoulderY = 0.28;
  double _smoothShoulderL = 0.32;
  double _smoothShoulderR = 0.68;

  double _smoothChestY = 0.38;
  double _smoothChestL = 0.35;
  double _smoothChestR = 0.65;

  double _smoothWaistY = 0.48;
  double _smoothWaistL = 0.37;
  double _smoothWaistR = 0.63;

  double _smoothHipsY = 0.58;
  double _smoothHipsL = 0.34;
  double _smoothHipsR = 0.66;

  double _webStableHoldDuration = 0.0;

  /// Builds a [FrameAnalysisResult] from real vision data.
  ///
  /// On web [metrics] is always null and the result comes from the JS
  /// bridge. On mobile a null [metrics] means no person is currently
  /// detected.
  FrameAnalysisResult analyzeLivePose({
    required PoseBodyMetrics? metrics,
    required int currentAngleIndex, // 0 = front, 1 = side, 2 = back
  }) {
    // 1. Web: real-time contour data from body_vision.js
    final liveVisionJson = getLiveVisionJson();
    if (liveVisionJson != null && liveVisionJson.isNotEmpty) {
      final webResult = _analyzeWebVision(liveVisionJson);
      if (webResult != null) return webResult;
    }

    // 2. Mobile: ML Kit pose metrics (null ⇒ nobody in frame)
    if (metrics == null) return noPersonResult();

    return FrameAnalysisResult(
      confidence: metrics.confidence.clamp(0.0, 1.0),
      hasFullBody: metrics.fullBodyVisible,
      isTooClose: metrics.tooClose,
      isCutOffTop: metrics.cutOffTop,
      isCutOffBottom: metrics.cutOffBottom,
      statusMessage: _statusForMetrics(metrics, currentAngleIndex),
      shoulder: CaliperSpan(
        yRatio: metrics.shoulderY,
        leftXRatio: metrics.shoulderLeftX,
        rightXRatio: metrics.shoulderRightX,
        valueCm: metrics.shoulderWidthCm,
        isVisible: metrics.fullBodyVisible,
      ),
      chest: CaliperSpan(
        yRatio: metrics.chestY,
        leftXRatio: metrics.chestLeftX,
        rightXRatio: metrics.chestRightX,
        valueCm: metrics.chestWidthCm,
      ),
      waist: CaliperSpan(
        yRatio: metrics.waistY,
        leftXRatio: metrics.waistLeftX,
        rightXRatio: metrics.waistRightX,
        valueCm: metrics.waistWidthCm,
      ),
      hips: CaliperSpan(
        yRatio: metrics.hipsY,
        leftXRatio: metrics.hipsLeftX,
        rightXRatio: metrics.hipsRightX,
        valueCm: metrics.hipsWidthCm,
        isVisible: metrics.fullBodyVisible,
      ),
      headYRatio: metrics.headYRatio,
      feetYRatio: metrics.feetYRatio,
      centerXRatio: metrics.centerX,
      detectedMeasurements: {
        'shoulder': metrics.shoulderWidthCm,
        'chest': metrics.chestWidthCm,
        'waist': metrics.waistWidthCm,
        'hips': metrics.hipsWidthCm,
      },
      sideDepths: {
        'chest': metrics.sideChestDepthCm,
        'waist': metrics.sideWaistDepthCm,
      },
    );
  }

  String _statusForMetrics(PoseBodyMetrics metrics, int currentAngleIndex) {
    if (!metrics.fullBodyVisible) {
      if (metrics.tooClose) return 'TOO CLOSE — STEP BACK';
      if (metrics.cutOffTop || metrics.cutOffBottom) {
        return 'MOVE TO FIT YOUR FULL BODY IN FRAME';
      }
      return 'STEP INTO FRAME — SHOW YOUR FULL BODY';
    }
    if (currentAngleIndex == 1 && !metrics.looksSideways) {
      return 'TURN 90° TO YOUR SIDE';
    }
    return 'HOLD STEADY — STAND IN A-POSE';
  }

  /// Explicit no-person state for the UI to show when vision data goes
  /// stale (person walked out of frame, stream interrupted). Never
  /// fabricates measurements — the UI must clear, not freeze.
  FrameAnalysisResult noPersonResult() {
    const hidden = CaliperSpan(
      yRatio: 0,
      leftXRatio: 0,
      rightXRatio: 0,
      valueCm: 0,
      isVisible: false,
    );
    return const FrameAnalysisResult(
      confidence: 0.12,
      hasFullBody: false,
      isTooClose: false,
      isCutOffTop: false,
      isCutOffBottom: false,
      statusMessage: 'NO PERSON DETECTED — STEP INTO FRAME',
      shoulder: hidden,
      chest: hidden,
      waist: hidden,
      hips: hidden,
      centerXRatio: 0.5,
      detectedMeasurements: {},
    );
  }

  /// Parses the JSON produced by `web/body_vision.js` (real pixel contour
  /// detection). Returns null when the payload is unusable.
  FrameAnalysisResult? _analyzeWebVision(String liveVisionJson) {
    try {
      final Map<String, dynamic> data = jsonDecode(liveVisionJson);
      final bool hasPerson = data['hasPerson'] == true;
      final bool hasFullBody = data['hasFullBody'] == true;
      final bool isTooClose = data['isTooClose'] == true;
      final bool isCutOffTop = data['isCutOffTop'] == true;
      final bool isCutOffBottom = data['isCutOffBottom'] == true;
      double confidence = (data['confidence'] as num?)?.toDouble() ?? 0.2;
      String statusMessage =
          (data['statusMessage'] as String?) ?? 'ANALYZING...';

      final landmarks = data['landmarks'] as Map<String, dynamic>?;
      if (landmarks == null || !hasPerson) return null;

      final sh = landmarks['shoulder'] as Map<String, dynamic>?;
      final ch = landmarks['chest'] as Map<String, dynamic>?;
      final ws = landmarks['waist'] as Map<String, dynamic>?;
      final hp = landmarks['hips'] as Map<String, dynamic>?;

      // A missing calibrated cm value means the bridge payload is
      // incomplete. Never substitute canned numbers — an incomplete payload
      // is invalid data, not a partial measurement.
      final shCm = (sh?['cm'] as num?)?.toDouble();
      final chCm = (ch?['cm'] as num?)?.toDouble();
      final wsCm = (ws?['cm'] as num?)?.toDouble();
      final hpCm = (hp?['cm'] as num?)?.toDouble();
      if (shCm == null || chCm == null || wsCm == null || hpCm == null) {
        return null;
      }

      final shY = (sh?['y'] as num?)?.toDouble() ?? 0.28;
      final shL = (sh?['leftX'] as num?)?.toDouble() ?? 0.32;
      final shR = (sh?['rightX'] as num?)?.toDouble() ?? 0.68;

      final chY = (ch?['y'] as num?)?.toDouble() ?? 0.38;
      final chL = (ch?['leftX'] as num?)?.toDouble() ?? 0.35;
      final chR = (ch?['rightX'] as num?)?.toDouble() ?? 0.65;

      final wsY = (ws?['y'] as num?)?.toDouble() ?? 0.48;
      final wsL = (ws?['leftX'] as num?)?.toDouble() ?? 0.37;
      final wsR = (ws?['rightX'] as num?)?.toDouble() ?? 0.63;

      final hpY = (hp?['y'] as num?)?.toDouble() ?? 0.58;
      final hpL = (hp?['leftX'] as num?)?.toDouble() ?? 0.34;
      final hpR = (hp?['rightX'] as num?)?.toDouble() ?? 0.66;

      // Smooth exponential filter (EMA) to eliminate frame jitter
      _smoothShoulderY = _smoothShoulderY * 0.7 + shY * 0.3;
      _smoothShoulderL = _smoothShoulderL * 0.7 + shL * 0.3;
      _smoothShoulderR = _smoothShoulderR * 0.7 + shR * 0.3;

      _smoothChestY = _smoothChestY * 0.7 + chY * 0.3;
      _smoothChestL = _smoothChestL * 0.7 + chL * 0.3;
      _smoothChestR = _smoothChestR * 0.7 + chR * 0.3;

      _smoothWaistY = _smoothWaistY * 0.7 + wsY * 0.3;
      _smoothWaistL = _smoothWaistL * 0.7 + wsL * 0.3;
      _smoothWaistR = _smoothWaistR * 0.7 + wsR * 0.3;

      _smoothHipsY = _smoothHipsY * 0.7 + hpY * 0.3;
      _smoothHipsL = _smoothHipsL * 0.7 + hpL * 0.3;
      _smoothHipsR = _smoothHipsR * 0.7 + hpR * 0.3;

      // Track multi-angle transition hold time
      if (hasFullBody) {
        _webStableHoldDuration += 0.1;
        if (_webStableHoldDuration > 1.2) {
          confidence =
              math.min(1.0, 0.85 + (0.15 * (_webStableHoldDuration - 1.2)));
        }
      } else {
        _webStableHoldDuration = 0.0;
      }

      return FrameAnalysisResult(
        confidence: confidence.clamp(0.0, 1.0),
        hasFullBody: hasFullBody,
        isTooClose: isTooClose,
        isCutOffTop: isCutOffTop,
        isCutOffBottom: isCutOffBottom,
        statusMessage: statusMessage,
        shoulder: CaliperSpan(
          yRatio: _smoothShoulderY,
          leftXRatio: _smoothShoulderL,
          rightXRatio: _smoothShoulderR,
          valueCm: shCm,
          isVisible: !isCutOffTop,
        ),
        chest: CaliperSpan(
          yRatio: _smoothChestY,
          leftXRatio: _smoothChestL,
          rightXRatio: _smoothChestR,
          valueCm: chCm,
        ),
        waist: CaliperSpan(
          yRatio: _smoothWaistY,
          leftXRatio: _smoothWaistL,
          rightXRatio: _smoothWaistR,
          valueCm: wsCm,
        ),
        hips: CaliperSpan(
          yRatio: _smoothHipsY,
          leftXRatio: _smoothHipsL,
          rightXRatio: _smoothHipsR,
          valueCm: hpCm,
          isVisible: !isCutOffBottom,
        ),
        headYRatio: (landmarks['headY'] as num?)?.toDouble(),
        feetYRatio: (landmarks['feetY'] as num?)?.toDouble(),
        centerXRatio: (_smoothShoulderL + _smoothShoulderR) / 2.0,
        detectedMeasurements: {
          'shoulder': shCm,
          'chest': chCm,
          'waist': wsCm,
          'hips': hpCm,
        },
        // In a side view the JS contour's horizontal extent is the torso
        // depth, so the chest/waist contour values double as side depths.
        sideDepths: {
          'chest': chCm,
          'waist': wsCm,
        },
      );
    } catch (e) {
      return null;
    }
  }
}
