import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

import 'pose_estimation_service.dart';

/// Real-time body metrics derived from ML Kit pose landmarks.
///
/// Every value here originates from actual camera frames: landmark pixel
/// geometry is converted to centimeters using the user's real height for
/// scale calibration. Nothing is timer-driven or hardcoded.
class PoseBodyMetrics {
  /// Full front widths in centimeters, measured from landmark geometry.
  final double shoulderWidthCm;
  final double chestWidthCm;
  final double waistWidthCm;
  final double hipsWidthCm;

  /// Display-space (0.0–1.0) caliper geometry for the measurement overlay.
  /// Already corrected for sensor rotation and front-camera mirroring.
  final double shoulderY;
  final double shoulderLeftX;
  final double shoulderRightX;
  final double chestY;
  final double chestLeftX;
  final double chestRightX;
  final double waistY;
  final double waistLeftX;
  final double waistRightX;
  final double hipsY;
  final double hipsLeftX;
  final double hipsRightX;
  final double centerX;
  final double? headYRatio;
  final double? feetYRatio;

  /// Mean landmark likelihood (0.0–1.0) of the required joints.
  final double confidence;
  final bool fullBodyVisible;
  final bool tooClose;
  final bool cutOffTop;
  final bool cutOffBottom;

  /// True when the shoulders appear compressed horizontally relative to
  /// [referenceShoulderPx] — i.e. the person has turned sideways.
  final bool looksSideways;

  /// Raw pixel distance between the shoulder joints (used for turn checks).
  final double shoulderSeparationPx;

  /// Front-to-back torso depth in centimeters, measured from the side view.
  ///
  /// When the user turns 90°, the left/right joint separation collapses onto
  /// the depth axis: shoulder separation ≈ chest depth, hip separation ≈
  /// hip depth. These are real camera-derived measurements (documented
  /// approximations), not canned values.
  final double sideChestDepthCm;
  final double sideWaistDepthCm;

  const PoseBodyMetrics({
    required this.shoulderWidthCm,
    required this.chestWidthCm,
    required this.waistWidthCm,
    required this.hipsWidthCm,
    required this.shoulderY,
    required this.shoulderLeftX,
    required this.shoulderRightX,
    required this.chestY,
    required this.chestLeftX,
    required this.chestRightX,
    required this.waistY,
    required this.waistLeftX,
    required this.waistRightX,
    required this.hipsY,
    required this.hipsLeftX,
    required this.hipsRightX,
    required this.centerX,
    this.headYRatio,
    this.feetYRatio,
    required this.confidence,
    required this.fullBodyVisible,
    required this.tooClose,
    required this.cutOffTop,
    required this.cutOffBottom,
    required this.looksSideways,
    required this.shoulderSeparationPx,
    required this.sideChestDepthCm,
    required this.sideWaistDepthCm,
  });

  /// Adapts an ML Kit [Pose] into plain landmark points. Returns null when
  /// the landmarks are insufficient for measurement.
  static PoseBodyMetrics? fromPose({
    required Pose pose,
    required int imageWidth,
    required int imageHeight,
    required InputImageRotation rotation,
    required bool mirrorHorizontally,
    required double heightCm,
    double? referenceShoulderPx,
  }) {
    final points = <PoseLandmarkType, math.Point<double>>{};
    final likelihoods = <PoseLandmarkType, double>{};
    for (final entry in pose.landmarks.entries) {
      points[entry.key] = math.Point(entry.value.x, entry.value.y);
      likelihoods[entry.key] = entry.value.likelihood;
    }
    return PoseBodyMetrics.fromLandmarkPoints(
      points: points,
      likelihoods: likelihoods,
      imageWidth: imageWidth,
      imageHeight: imageHeight,
      rotation: rotation,
      mirrorHorizontally: mirrorHorizontally,
      heightCm: heightCm,
      referenceShoulderPx: referenceShoulderPx,
    );
  }

  /// Core geometry, operating on plain landmark points so it stays
  /// unit-testable without a camera or the ML Kit native SDKs.
  ///
  /// Width estimation notes (documented approximations):
  /// - Shoulder width is measured directly (biacromial joint distance).
  /// - Chest/waist widths interpolate the torso joint line at fixed
  ///   anatomical fractions and expand it by a contour factor, because the
  ///   joints sit inside the body surface.
  /// - Hip breadth ≈ hip joint distance × 1.7 (hip joints are well medial of
  ///   the outer contour).
  ///
  /// Returns null when the core joints are missing or the scale cannot be
  /// calibrated (no usable stature reference in frame).
  static PoseBodyMetrics? fromLandmarkPoints({
    required Map<PoseLandmarkType, math.Point<double>> points,
    required Map<PoseLandmarkType, double> likelihoods,
    required int imageWidth,
    required int imageHeight,
    required InputImageRotation rotation,
    required bool mirrorHorizontally,
    required double heightCm,
    double? referenceShoulderPx,
  }) {
    math.Point<double>? need(PoseLandmarkType type,
        [double minLikelihood = 0.5]) {
      final p = points[type];
      final l = likelihoods[type] ?? 0.0;
      return (p != null && l >= minLikelihood) ? p : null;
    }

    final shL = need(PoseLandmarkType.leftShoulder);
    final shR = need(PoseLandmarkType.rightShoulder);
    final hipL = need(PoseLandmarkType.leftHip);
    final hipR = need(PoseLandmarkType.rightHip);
    // Core joints are mandatory — without them there is no measurement.
    if (shL == null || shR == null || hipL == null || hipR == null) {
      return null;
    }

    final nose = need(PoseLandmarkType.nose);
    final ankL = need(PoseLandmarkType.leftAnkle);
    final ankR = need(PoseLandmarkType.rightAnkle);

    double dist(math.Point<double> a, math.Point<double> b) =>
        math.sqrt(math.pow(a.x - b.x, 2) + math.pow(a.y - b.y, 2));

    final shoulderPx = dist(shL, shR);
    final hipJointPx = dist(hipL, hipR);
    final shoulderMid = math.Point((shL.x + shR.x) / 2, (shL.y + shR.y) / 2);
    final hipMid = math.Point((hipL.x + hipR.x) / 2, (hipL.y + hipR.y) / 2);

    // ── Scale calibration: pixels → centimeters ──────────────────────
    // Stature in pixels, estimated from nose→ankle (≈93% of true stature)
    // or shoulder→ankle (≈81.8% of stature) when the head is out of frame.
    double? staturePx;
    if (nose != null && ankL != null && ankR != null) {
      final ankleMidY = (ankL.y + ankR.y) / 2;
      staturePx = (ankleMidY - nose.y).abs() / 0.93;
    } else if (ankL != null && ankR != null) {
      final ankleMidY = (ankL.y + ankR.y) / 2;
      staturePx = (ankleMidY - shoulderMid.y).abs() / 0.818;
    }
    if (staturePx == null || staturePx <= 0) return null;
    final cmPerPx = heightCm / staturePx;

    // ── Widths ───────────────────────────────────────────────────────
    final shoulderHalfPx = shoulderPx / 2;
    final hipHalfPx = hipJointPx / 2;

    double contourHalfPxAt(double t, double contourFactor) {
      final jointHalf = shoulderHalfPx + (hipHalfPx - shoulderHalfPx) * t;
      return jointHalf * contourFactor;
    }

    math.Point<double> torsoPointAt(double t) => math.Point(
          shoulderMid.x + (hipMid.x - shoulderMid.x) * t,
          shoulderMid.y + (hipMid.y - shoulderMid.y) * t,
        );

    final shoulderWidthCm = shoulderPx * cmPerPx;
    final chestHalfPx = contourHalfPxAt(0.25, 1.06);
    final waistHalfPx = contourHalfPxAt(0.55, 0.94);
    final hipsHalfPx = hipJointPx * 1.7 / 2;
    final chestWidthCm = chestHalfPx * 2 * cmPerPx;
    final waistWidthCm = waistHalfPx * 2 * cmPerPx;
    final hipsWidthCm = hipsHalfPx * 2 * cmPerPx;

    // ── Side-view depths ───────────────────────────────────────────
    // In a 90° side view the left/right joint separation lies along the
    // camera's depth axis, so it measures torso depth rather than width:
    // shoulder separation ≈ chest depth, hip separation ≈ hip depth.
    // Waist depth interpolates between the two at the waist fraction.
    final sideChestDepthCm = shoulderPx * 0.98 * cmPerPx;
    final sideWaistDepthCm =
        (shoulderPx + (hipJointPx - shoulderPx) * 0.55) * 0.95 * cmPerPx;

    // ── Quality signals ────────────────────────────────────────────
    const coreTypes = [
      PoseLandmarkType.leftShoulder,
      PoseLandmarkType.rightShoulder,
      PoseLandmarkType.leftHip,
      PoseLandmarkType.rightHip,
    ];
    double likelihoodSum = 0;
    for (final t in coreTypes) {
      likelihoodSum += likelihoods[t] ?? 0.0;
    }
    int extraCount = 0;
    for (final t in [
      PoseLandmarkType.nose,
      PoseLandmarkType.leftAnkle,
      PoseLandmarkType.rightAnkle,
    ]) {
      final l = likelihoods[t];
      if (l != null && l >= 0.5) {
        likelihoodSum += l;
        extraCount++;
      }
    }
    final confidence = likelihoodSum / (coreTypes.length + extraCount);
    final fullBodyVisible = nose != null && ankL != null && ankR != null;

    // ── Display-space normalization ────────────────────────────────
    // ML Kit reports landmarks in the raw (unrotated) image space; map them
    // into upright display space (0.0–1.0) so the overlay draws correctly.
    Offset toDisplay(math.Point<double> p) {
      final x = p.x;
      final y = p.y;
      double u, v;
      switch (rotation) {
        case InputImageRotation.rotation90deg:
          u = 1 - y / imageHeight;
          v = x / imageWidth;
          break;
        case InputImageRotation.rotation180deg:
          u = 1 - x / imageWidth;
          v = 1 - y / imageHeight;
          break;
        case InputImageRotation.rotation270deg:
          u = y / imageHeight;
          v = 1 - x / imageWidth;
          break;
        case InputImageRotation.rotation0deg:
          u = x / imageWidth;
          v = y / imageHeight;
          break;
      }
      if (mirrorHorizontally) u = 1 - u;
      return Offset(u, v);
    }

    // A horizontal distance in image pixels maps to display width; for
    // 90°/270° rotations the display width corresponds to the image height.
    final displayWidthPx = (rotation == InputImageRotation.rotation90deg ||
            rotation == InputImageRotation.rotation270deg)
        ? imageHeight.toDouble()
        : imageWidth.toDouble();
    final displayHeightPx = (rotation == InputImageRotation.rotation90deg ||
            rotation == InputImageRotation.rotation270deg)
        ? imageWidth.toDouble()
        : imageHeight.toDouble();

    // Returns [y, leftX, rightX] for a caliper line.
    List<double> caliper(double t, double halfPx) {
      final c = toDisplay(torsoPointAt(t));
      final h = halfPx / displayWidthPx;
      return [c.dy, c.dx - h, c.dx + h];
    }

    final sh = caliper(0.0, shoulderHalfPx);
    final ch = caliper(0.25, chestHalfPx);
    final wa = caliper(0.55, waistHalfPx);
    final hp = caliper(1.0, hipsHalfPx);

    final center = toDisplay(math.Point(
      (shoulderMid.x + hipMid.x) / 2,
      (shoulderMid.y + hipMid.y) / 2,
    ));

    double? headY;
    double? feetY;
    if (nose != null) {
      // Crown of the head sits a little above the nose landmark.
      headY = (toDisplay(nose).dy - 0.06).clamp(0.0, 1.0);
    }
    if (ankL != null && ankR != null) {
      feetY = math.max(toDisplay(ankL).dy, toDisplay(ankR).dy).clamp(0.0, 1.0);
    }

    final tooClose = staturePx / displayHeightPx > 0.92;
    final cutOffTop = nose != null && toDisplay(nose).dy < 0.05;
    final cutOffBottom = feetY != null && feetY > 0.98;
    final looksSideways = referenceShoulderPx != null &&
        referenceShoulderPx > 0 &&
        shoulderPx < referenceShoulderPx * 0.5;

    return PoseBodyMetrics(
      shoulderWidthCm: shoulderWidthCm,
      chestWidthCm: chestWidthCm,
      waistWidthCm: waistWidthCm,
      hipsWidthCm: hipsWidthCm,
      shoulderY: sh[0],
      shoulderLeftX: sh[1],
      shoulderRightX: sh[2],
      chestY: ch[0],
      chestLeftX: ch[1],
      chestRightX: ch[2],
      waistY: wa[0],
      waistLeftX: wa[1],
      waistRightX: wa[2],
      hipsY: hp[0],
      hipsLeftX: hp[1],
      hipsRightX: hp[2],
      centerX: center.dx,
      headYRatio: headY,
      feetYRatio: feetY,
      confidence: confidence.clamp(0.0, 1.0),
      fullBodyVisible: fullBodyVisible,
      tooClose: tooClose,
      cutOffTop: cutOffTop,
      cutOffBottom: cutOffBottom,
      looksSideways: looksSideways,
      shoulderSeparationPx: shoulderPx,
      sideChestDepthCm: sideChestDepthCm,
      sideWaistDepthCm: sideWaistDepthCm,
    );
  }
}

/// Feeds live camera frames into ML Kit pose detection.
///
/// Handles throttling (so the detector isn't overwhelmed), the
/// [CameraImage] → [InputImage] conversion for Android/iOS, and pose
/// stability tracking used for hands-free auto-capture.
class PoseFrameProcessor {
  final PoseEstimationService _poseService = PoseEstimationService();

  bool _isBusy = false;
  DateTime _lastFrameTime = DateTime.fromMillisecondsSinceEpoch(0);
  static const _minFrameInterval = Duration(milliseconds: 120);

  final List<Pose> _recentPoses = [];
  static const _maxRecentPoses = 15;

  /// True while a frame is being processed — callers should skip new frames.
  bool get isProcessing => _isBusy;

  /// True when recent poses are consistent enough to trust for capture.
  bool get isStable => _poseService.isPoseStable(_recentPoses);

  void resetStability() => _recentPoses.clear();

  /// Runs pose detection on a camera frame (throttled to ~8 fps).
  ///
  /// Returns the measured body metrics, or null when no person is detected,
  /// the frame was skipped (throttle/busy), or the platform isn't supported
  /// (web uses the JavaScript vision bridge instead).
  Future<PoseBodyMetrics?> processFrame(
    CameraImage image,
    CameraDescription description,
    DeviceOrientation deviceOrientation, {
    required double heightCm,
    double? referenceShoulderPx,
    bool mirrorHorizontally = true,
  }) async {
    final now = DateTime.now();
    if (_isBusy || now.difference(_lastFrameTime) < _minFrameInterval) {
      return null;
    }
    _isBusy = true;
    _lastFrameTime = now;
    try {
      final inputImage = _toInputImage(image, description, deviceOrientation);
      if (inputImage == null) return null;

      final pose = await _poseService.detectPose(inputImage);
      if (pose == null) {
        _recentPoses.clear();
        return null;
      }
      _recentPoses.add(pose);
      if (_recentPoses.length > _maxRecentPoses) _recentPoses.removeAt(0);

      return PoseBodyMetrics.fromPose(
        pose: pose,
        imageWidth: image.width,
        imageHeight: image.height,
        rotation: inputImage.metadata!.rotation,
        mirrorHorizontally: mirrorHorizontally,
        heightCm: heightCm,
        referenceShoulderPx: referenceShoulderPx,
      );
    } catch (_) {
      // A corrupt frame must never crash the scan — just skip it.
      return null;
    } finally {
      _isBusy = false;
    }
  }

  /// Converts a camera frame into an ML Kit [InputImage], handling sensor
  /// orientation, device orientation and front-camera mirroring.
  InputImage? _toInputImage(
    CameraImage image,
    CameraDescription description,
    DeviceOrientation deviceOrientation,
  ) {
    // Pose detection is wired for Android & iOS. Web goes through the
    // JavaScript vision bridge (see vision_bridge.dart) instead.
    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    final isIOS = defaultTargetPlatform == TargetPlatform.iOS;
    if (!isAndroid && !isIOS) return null;

    final sensorOrientation = description.sensorOrientation;
    InputImageRotation? rotation;
    if (isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else {
      final compensation = _orientationCompensation(deviceOrientation);
      final degrees = description.lensDirection == CameraLensDirection.front
          ? (sensorOrientation + compensation) % 360
          : (sensorOrientation - compensation + 360) % 360;
      rotation = InputImageRotationValue.fromRawValue(degrees);
    }
    if (rotation == null) return null;

    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    if (format == null) return null;

    late final Uint8List bytes;
    late final int bytesPerRow;
    if (image.planes.length == 1) {
      if (isAndroid && format != InputImageFormat.nv21) return null;
      if (isIOS && format != InputImageFormat.bgra8888) return null;
      bytes = image.planes.first.bytes;
      bytesPerRow = image.planes.first.bytesPerRow;
    } else {
      // YUV_420_888 (3 planes) → repack as NV21 for ML Kit.
      if (!isAndroid) return null;
      if (format != InputImageFormat.yuv420 &&
          format != InputImageFormat.nv21) {
        return null;
      }
      bytes = _yuv420ToNv21(image);
      bytesPerRow = image.width;
    }

    return InputImage.fromBytes(
      bytes: bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation,
        // After repacking, the buffer is always NV21 on Android.
        format: isAndroid ? InputImageFormat.nv21 : format,
        bytesPerRow: bytesPerRow,
      ),
    );
  }

  int _orientationCompensation(DeviceOrientation orientation) {
    switch (orientation) {
      case DeviceOrientation.portraitUp:
        return 0;
      case DeviceOrientation.landscapeLeft:
        return 90;
      case DeviceOrientation.portraitDown:
        return 180;
      case DeviceOrientation.landscapeRight:
        return 270;
    }
  }

  /// Repacks YUV_420_888 planes into a single NV21 buffer.
  Uint8List _yuv420ToNv21(CameraImage image) {
    final yPlane = image.planes[0];
    final uPlane = image.planes[1];
    final vPlane = image.planes[2];

    final ySize = yPlane.bytes.length;
    final nv21 = Uint8List(ySize + yPlane.bytes.length ~/ 2);
    nv21.setRange(0, ySize, yPlane.bytes);

    final uvRowStride = uPlane.bytesPerRow;
    final uvPixelStride = uPlane.bytesPerPixel ?? 1;
    var offset = ySize;
    for (var row = 0; row < image.height ~/ 2; row++) {
      for (var col = 0; col < image.width ~/ 2; col++) {
        final uvIndex = row * uvRowStride + col * uvPixelStride;
        nv21[offset++] = vPlane.bytes[uvIndex];
        nv21[offset++] = uPlane.bytes[uvIndex];
      }
    }
    return nv21;
  }

  void dispose() {
    _poseService.dispose();
  }
}
