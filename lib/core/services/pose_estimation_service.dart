import 'dart:math' as math;
import 'dart:ui';

import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

/// Thin wrapper around ML Kit's on-device pose detector.
///
/// Runs fully on-device (no images leave the phone) in stream mode, which
/// is tuned for continuous frame-by-frame detection.
class PoseEstimationService {
  late final PoseDetector _poseDetector;

  PoseEstimationService() {
    final options = PoseDetectorOptions(
      mode: PoseDetectionMode.stream,
      model: PoseDetectionModel.accurate,
    );
    _poseDetector = PoseDetector(options: options);
  }

  /// Returns the most prominent detected pose, or null when nobody is found.
  Future<Pose?> detectPose(InputImage image) async {
    final poses = await _poseDetector.processImage(image);
    if (poses.isNotEmpty) return poses.first;
    return null;
  }

  /// True when the key body joints are present and confident enough to
  /// measure from.
  bool isFullBodyVisible(Pose pose) {
    final landmarks = pose.landmarks;
    const requiredLandmarks = [
      PoseLandmarkType.leftShoulder,
      PoseLandmarkType.rightShoulder,
      PoseLandmarkType.leftHip,
      PoseLandmarkType.rightHip,
      PoseLandmarkType.leftAnkle,
      PoseLandmarkType.rightAnkle,
    ];

    for (final type in requiredLandmarks) {
      final landmark = landmarks[type];
      if (landmark == null || landmark.likelihood < 0.6) {
        return false;
      }
    }
    return true;
  }

  /// True when the user is holding still: the shoulder center barely moves
  /// across the recent pose window. Used to gate hands-free auto-capture.
  bool isPoseStable(List<Pose> recentPoses) {
    if (recentPoses.length < 8) return false;

    final centers = <Offset>[];
    for (final pose in recentPoses) {
      final l = pose.landmarks[PoseLandmarkType.leftShoulder];
      final r = pose.landmarks[PoseLandmarkType.rightShoulder];
      if (l == null || r == null) return false;
      centers.add(Offset((l.x + r.x) / 2, (l.y + r.y) / 2));
    }

    final n = centers.length;
    final meanX = centers.fold(0.0, (sum, c) => sum + c.dx) / n;
    final meanY = centers.fold(0.0, (sum, c) => sum + c.dy) / n;
    final variance = centers.fold(
            0.0,
            (sum, c) =>
                sum + math.pow(c.dx - meanX, 2) + math.pow(c.dy - meanY, 2)) /
        n;

    // Standard deviation of the shoulder center under ~14 px ⇒ holding still.
    return math.sqrt(variance) < 14.0;
  }

  void dispose() {
    _poseDetector.close();
  }
}
