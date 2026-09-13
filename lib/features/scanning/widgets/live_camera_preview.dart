import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_typography.dart';
import '../../../config/theme/app_spacing.dart';

class LiveCameraPreview extends StatefulWidget {
  final Function(CameraController controller)? onCameraReady;

  /// Called right before the current controller is disposed or replaced
  /// (camera switch, app backgrounding) so the parent can stop its image
  /// stream first. Starting a stream on a disposed controller throws.
  final VoidCallback? onCameraDisposing;
  final bool mirror;

  const LiveCameraPreview({
    super.key,
    this.onCameraReady,
    this.onCameraDisposing,
    this.mirror = true,
  });

  @override
  State<LiveCameraPreview> createState() => _LiveCameraPreviewState();
}

class _LiveCameraPreviewState extends State<LiveCameraPreview>
    with WidgetsBindingObserver {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isInitializing = true;
  String? _errorMessage;
  int _selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    widget.onCameraDisposing?.call();
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      widget.onCameraDisposing?.call();
      cameraController.dispose();
      _controller = null;
    } else if (state == AppLifecycleState.resumed) {
      _initCamera();
    }
  }

  Future<void> _initCamera() async {
    setState(() {
      _isInitializing = true;
      _errorMessage = null;
    });

    try {
      _cameras = await availableCameras();
      if (_cameras == null || _cameras!.isEmpty) {
        setState(() {
          _isInitializing = false;
          _errorMessage = 'No camera found on this device.';
        });
        return;
      }

      // Default to front camera for selfie body scan
      int frontIndex = _cameras!.indexWhere(
        (c) => c.lensDirection == CameraLensDirection.front,
      );
      _selectedCameraIndex = frontIndex != -1 ? frontIndex : 0;

      await _setupController(_cameras![_selectedCameraIndex]);
    } catch (e) {
      setState(() {
        _isInitializing = false;
        _errorMessage =
            'Camera access error: ${e.toString().split('\n').first}';
      });
    }
  }

  Future<void> _setupController(CameraDescription cameraDescription) async {
    // Let the parent stop any image stream on the old controller before we
    // replace it.
    widget.onCameraDisposing?.call();
    await _controller?.dispose();
    _controller = null;

    final controller = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await controller.initialize();
      if (!mounted) {
        await controller.dispose();
        return;
      }

      setState(() {
        _controller = controller;
        _isInitializing = false;
      });

      widget.onCameraReady?.call(controller);
    } catch (e) {
      if (mounted) {
        setState(() {
          _isInitializing = false;
          _errorMessage =
              'Failed to start camera. Please ensure permissions are granted.';
        });
      }
    }
  }

  void _switchCamera() async {
    if (_cameras == null || _cameras!.length < 2) return;
    final nextIndex = (_selectedCameraIndex + 1) % _cameras!.length;
    _selectedCameraIndex = nextIndex;
    await _setupController(_cameras![nextIndex]);
  }

  @override
  Widget build(BuildContext context) {
    if (_isInitializing) {
      return Container(
        color: Colors.black,
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: AppColors.primaryGold),
              SizedBox(height: AppSpacing.md),
              Text(
                'Accessing Camera Sensor...',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
        ),
      );
    }

    final isWebInsecure =
        kIsWeb && Uri.base.scheme == 'http' && Uri.base.host != 'localhost';

    if (_errorMessage != null ||
        _controller == null ||
        !_controller!.value.isInitialized) {
      return Container(
        color: const Color(0xFF0D1117),
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color:
                      (isWebInsecure ? AppColors.primaryGold : Colors.redAccent)
                          .withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isWebInsecure
                      ? Icons.lock_open_rounded
                      : Icons.videocam_off_rounded,
                  color:
                      isWebInsecure ? AppColors.primaryGold : Colors.redAccent,
                  size: 40,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                isWebInsecure
                    ? 'Secure Camera Access Required'
                    : 'Camera Feed Not Available',
                style: AppTypography.titleMedium
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                isWebInsecure
                    ? 'Apple iOS Safari requires HTTPS (secure connection) to unlock the camera on your iPhone over Wi-Fi.'
                    : (_errorMessage ??
                        'Please allow camera permissions in your browser or device settings.'),
                textAlign: TextAlign.center,
                style: AppTypography.bodySmall.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: AppSpacing.lg),
              if (isWebInsecure)
                ElevatedButton.icon(
                  onPressed: () {
                    launchUrl(
                      Uri.parse('https://${Uri.base.host}:8443/#/scan/capture'),
                      mode: LaunchMode.platformDefault,
                    );
                  },
                  icon: const Icon(Icons.lock_rounded, size: 18),
                  label: const Text('SWITCH TO SECURE CAMERA (HTTPS)'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGold,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              else
                ElevatedButton.icon(
                  onPressed: _initCamera,
                  icon: const Icon(Icons.refresh_rounded, size: 18),
                  label: const Text('RETRY CAMERA'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGold,
                    foregroundColor: Colors.black,
                  ),
                ),
            ],
          ),
        ),
      );
    }

    // Live Camera Stream
    Widget preview = CameraPreview(_controller!);

    // Mirror preview if front camera
    if (widget.mirror &&
        _cameras != null &&
        _cameras![_selectedCameraIndex].lensDirection ==
            CameraLensDirection.front) {
      preview = Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(3.14159), // Flip horizontally
        child: preview,
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        // Camera Video Frame - Correct Portrait Wide Angle (Uncropped)
        Center(
          child: FittedBox(
            fit: BoxFit.contain,
            child: SizedBox(
              width: _controller!.value.previewSize != null
                  ? math.min(_controller!.value.previewSize!.width,
                      _controller!.value.previewSize!.height)
                  : 720,
              height: _controller!.value.previewSize != null
                  ? math.max(_controller!.value.previewSize!.width,
                      _controller!.value.previewSize!.height)
                  : 1280,
              child: preview,
            ),
          ),
        ),

        // Lens switch button if multiple cameras
        if (_cameras != null && _cameras!.length > 1)
          Positioned(
            top: 50,
            right: 20,
            child: IconButton(
              onPressed: _switchCamera,
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.flip_camera_ios_rounded,
                    color: Colors.white, size: 22),
              ),
            ),
          ),
      ],
    );
  }
}
