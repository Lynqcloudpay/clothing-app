import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_typography.dart';

class ARCameraView extends StatefulWidget {
  const ARCameraView({super.key});

  @override
  State<ARCameraView> createState() => _ARCameraViewState();
}

class _ARCameraViewState extends State<ARCameraView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scanLaserController;
  late final Animation<double> _laserPosition;

  @override
  void initState() {
    super.initState();
    _scanLaserController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    _laserPosition = CurvedAnimation(
      parent: _scanLaserController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scanLaserController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0A0D14),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Perspective Depth Grid
          CustomPaint(
            painter: _PerspectiveGridPainter(),
          ),

          // 2. Animated LiDAR Scan Laser
          AnimatedBuilder(
            animation: _laserPosition,
            builder: (context, child) {
              return CustomPaint(
                painter: _LaserScanPainter(progress: _laserPosition.value),
              );
            },
          ),

          // 3. Sensor Status HUD
          Positioned(
            top: 60,
            left: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.primaryGold.withValues(alpha: 0.4)),
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
                  const SizedBox(width: 8),
                  Text(
                    'LiDAR / TrueDepth Active',
                    style: AppTypography.bodySmall.copyWith(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 4. Point Cloud Vertex Counter
          Positioned(
            bottom: 120,
            left: 20,
            child: Text(
              'DEPTH RESOLUTION: 1920x1440\nPOINT CLOUD: 48,290 PTS',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.primaryGold.withValues(alpha: 0.7),
                fontSize: 10,
                letterSpacing: 1.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PerspectiveGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1.0;

    const step = 40.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LaserScanPainter extends CustomPainter {
  final double progress;

  _LaserScanPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final y = size.height * 0.15 + (size.height * 0.70 * progress);

    // Glowing Laser Line
    final linePaint = Paint()
      ..shader = LinearGradient(
        colors: [
          AppColors.primaryGold.withValues(alpha: 0.0),
          AppColors.primaryGold,
          Colors.white,
          AppColors.primaryGold,
          AppColors.primaryGold.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(0, y, size.width, 3))
      ..strokeWidth = 2.5;

    canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);

    // Subtle laser beam wash
    final washPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.primaryGold.withValues(alpha: 0.15),
          AppColors.primaryGold.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(0, y - 40, size.width, 40));

    canvas.drawRect(Rect.fromLTWH(0, y - 40, size.width, 40), washPaint);
  }

  @override
  bool shouldRepaint(covariant _LaserScanPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
