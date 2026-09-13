import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class PoseEstimationService {
  late final PoseDetector _poseDetector;

  PoseEstimationService() {
    final options = PoseDetectorOptions(mode: PoseDetectionMode.stream);
    _poseDetector = PoseDetector(options: options);
  }

  Future<Pose?> detectPose(InputImage image) async {
    final poses = await _poseDetector.processImage(image);
    if (poses.isNotEmpty) return poses.first;
    return null;
  }

  bool isFullBodyVisible(Pose pose) {
    // Check if key landmarks are present and confident
    final landmarks = pose.landmarks;
    final requiredLandmarks = [
      PoseLandmarkType.leftShoulder,
      PoseLandmarkType.rightShoulder,
      PoseLandmarkType.leftHip,
      PoseLandmarkType.rightHip,
      PoseLandmarkType.leftAnkle,
      PoseLandmarkType.rightAnkle,
    ];

    for (var type in requiredLandmarks) {
      final landmark = landmarks[type];
      if (landmark == null || landmark.likelihood < 0.7) {
        return false;
      }
    }
    return true;
  }

  bool isPoseStable(List<Pose> recentPoses) {
    if (recentPoses.length < 10) return false;
    // TODO: implement logic checking that standard deviation of landmarks is small
    return true;
  }

  void dispose() {
    _poseDetector.close();
  }
}
