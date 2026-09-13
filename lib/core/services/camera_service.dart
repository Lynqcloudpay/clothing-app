import 'package:camera/camera.dart';

class CameraService {
  CameraController? _controller;
  List<CameraDescription> _cameras = [];

  Future<void> initialize() async {
    _cameras = await availableCameras();
    if (_cameras.isNotEmpty) {
      _controller = CameraController(
        _cameras.first,
        ResolutionPreset.high,
        enableAudio: false,
      );
      await _controller?.initialize();
    }
  }

  Future<void> dispose() async {
    await _controller?.dispose();
    _controller = null;
  }

  Future<void> startStream(void Function(CameraImage image) onAvailable) async {
    if (_controller?.value.isStreamingImages != true) {
      await _controller?.startImageStream(onAvailable);
    }
  }

  Future<void> stopStream() async {
    if (_controller?.value.isStreamingImages == true) {
      await _controller?.stopImageStream();
    }
  }

  Future<XFile?> captureFrame() async {
    if (_controller?.value.isInitialized == true) {
      return await _controller?.takePicture();
    }
    return null;
  }
}
