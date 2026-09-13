import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../config/routes/app_router.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_spacing.dart';
import '../../../config/theme/app_typography.dart';
import '../../../config/constants/app_strings.dart';
import '../../../core/providers/scan_provider.dart';
import '../../../core/widgets/gradient_button.dart';
import '../widgets/measurement_card.dart';

class ScanResultsScreen extends ConsumerWidget {
  const ScanResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(scanSessionProvider);
    final measurements = session.measurements;

    // No canned fallback: without a real completed scan there is nothing
    // honest to show. Offer a rescan instead of fabricating numbers.
    if (measurements == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.scanResultsTitle),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.close_rounded),
              onPressed: () => context.go(RoutePaths.feed),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.person_search_rounded,
                  size: 72,
                  color: AppColors.primaryGold,
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'No scan data yet',
                  textAlign: TextAlign.center,
                  style: AppTypography.titleLarge,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Complete a body scan to see your measurements here.',
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                GradientButton(
                  label: AppStrings.scanStartButton,
                  onPressed: () => context.go(RoutePaths.scanPrepare),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.scanResultsTitle),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () => context.go(RoutePaths.feed),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── 3D Avatar Visualization ────────────────────────
              Container(
                height: 280,
                decoration: BoxDecoration(
                  gradient: const RadialGradient(
                    center: Alignment(0, -0.2),
                    radius: 0.9,
                    colors: [Color(0xFF161B26), AppColors.backgroundPrimary],
                  ),
                  borderRadius:
                      BorderRadius.circular(AppSpacing.borderRadiusLg),
                  border: Border.all(
                      color: AppColors.primaryGold.withValues(alpha: 0.2)),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Animated 3D Mesh Wireframe Avatar
                    const _WireframeAvatarVisualizer(),

                    // Floating Badges
                    Positioned(
                      top: 14,
                      left: 14,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color:
                                  AppColors.primaryGold.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.view_in_ar,
                                size: 14, color: AppColors.primaryGold),
                            const SizedBox(width: 6),
                            Text(
                              'BODY MAP',
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.primaryGold,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 12,
                      child: Text(
                        'SCAN VISUALIZATION',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textTertiary,
                          fontSize: 9,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 600.ms),

              const SizedBox(height: AppSpacing.lg),

              // ── Body Type & Size Recommendation Banner ────────
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.primaryGold.withValues(alpha: 0.08),
                  borderRadius:
                      BorderRadius.circular(AppSpacing.borderRadiusMd),
                  border: Border.all(
                      color: AppColors.primaryGold.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primaryGold.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.accessibility_new_rounded,
                          color: AppColors.primaryGold, size: 24),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Body Shape: ${measurements.bodyType}',
                            style: AppTypography.titleMedium.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Recommended Size: US ${measurements.sizeUS} (EU ${measurements.sizeEU})',
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.primaryGold,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 200.ms),

              const SizedBox(height: AppSpacing.xl),

              // ── Section Title ────────────────────────────────
              Text(
                'Extracted Biometric Dimensions',
                style: AppTypography.titleLarge,
              ),
              const SizedBox(height: AppSpacing.sm),

              // ── Measurements Grid ────────────────────────────
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: AppSpacing.md,
                crossAxisSpacing: AppSpacing.md,
                childAspectRatio: 2.3,
                children: [
                  MeasurementCard(
                    icon: Icons.height_rounded,
                    label: 'Height',
                    value: '${measurements.height} cm',
                  ).animate().fadeIn(delay: 250.ms).slideY(begin: 0.1, end: 0),
                  MeasurementCard(
                    icon: Icons.compress_rounded,
                    label: 'Chest',
                    value: '${measurements.chestCircumference} cm',
                  ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1, end: 0),
                  MeasurementCard(
                    icon: Icons.fitness_center_rounded,
                    label: 'Waist',
                    value: '${measurements.waistCircumference} cm',
                  ).animate().fadeIn(delay: 350.ms).slideY(begin: 0.1, end: 0),
                  MeasurementCard(
                    icon: Icons.expand_more_rounded,
                    label: 'Hips',
                    value: '${measurements.hipCircumference} cm',
                  ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1, end: 0),
                  MeasurementCard(
                    icon: Icons.straighten_rounded,
                    label: 'Shoulders',
                    value: '${measurements.shoulderWidth} cm',
                  ).animate().fadeIn(delay: 450.ms).slideY(begin: 0.1, end: 0),
                  MeasurementCard(
                    icon: Icons.accessibility_rounded,
                    label: 'Inseam',
                    value: '${measurements.inseam} cm',
                  ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1, end: 0),
                ],
              ),

              const SizedBox(height: AppSpacing.xxl),

              // ── Actions ──────────────────────────────────────
              GradientButton(
                label: 'VIEW TAILORED RECOMMENDATIONS',
                onPressed: () => context.go(RoutePaths.feed),
              ).animate().fadeIn(delay: 600.ms),

              const SizedBox(height: AppSpacing.md),

              TextButton(
                onPressed: () => context.go(RoutePaths.scanPrepare),
                child: const Text(AppStrings.scanRescan),
              ).animate().fadeIn(delay: 700.ms),
            ],
          ),
        ),
      ),
    );
  }
}

/// Dynamic rotating 3D wireframe body avatar
class _WireframeAvatarVisualizer extends StatefulWidget {
  const _WireframeAvatarVisualizer();

  @override
  State<_WireframeAvatarVisualizer> createState() =>
      _WireframeAvatarVisualizerState();
}

class _WireframeAvatarVisualizerState extends State<_WireframeAvatarVisualizer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotationController,
      builder: (context, child) {
        return CustomPaint(
          size: const Size(180, 240),
          painter: _AvatarWireframePainter(
            rotationAngle: _rotationController.value * 2 * math.pi,
          ),
        );
      },
    );
  }
}

class _AvatarWireframePainter extends CustomPainter {
  final double rotationAngle;

  _AvatarWireframePainter({required this.rotationAngle});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    final linePaint = Paint()
      ..color = AppColors.primaryGold.withValues(alpha: 0.6)
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke;

    final jointPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // 3D Rotated landmark projection
    Offset project(double x, double y, double z) {
      final rad = rotationAngle;
      final rotX = x * math.cos(rad) - z * math.sin(rad);
      final rotZ = x * math.sin(rad) + z * math.cos(rad);
      final perspective = 1.0 + (rotZ / 250);
      return Offset(cx + rotX * perspective, cy + y * perspective);
    }

    // Key body nodes
    final head = project(0, -90, 0);
    final neck = project(0, -65, 0);
    final lShoulder = project(-40, -55, 0);
    final rShoulder = project(40, -55, 0);
    final lElbow = project(-55, -15, 0);
    final rElbow = project(55, -15, 0);
    final lWrist = project(-60, 25, 0);
    final rWrist = project(60, 25, 0);
    final chest = project(0, -35, 10);
    final waist = project(0, 0, 0);
    final lHip = project(-28, 20, 0);
    final rHip = project(28, 20, 0);
    final lKnee = project(-28, 65, 0);
    final rKnee = project(28, 65, 0);
    final lAnkle = project(-28, 110, 0);
    final rAnkle = project(28, 110, 0);

    // Draw Skeleton Lines
    void drawBone(Offset a, Offset b) => canvas.drawLine(a, b, linePaint);

    // Torso & Head
    canvas.drawCircle(head, 14, linePaint);
    drawBone(head, neck);
    drawBone(neck, chest);
    drawBone(chest, waist);
    drawBone(waist, lHip);
    drawBone(waist, rHip);
    drawBone(lHip, rHip);

    // Shoulders
    drawBone(neck, lShoulder);
    drawBone(neck, rShoulder);
    drawBone(lShoulder, chest);
    drawBone(rShoulder, chest);

    // Arms
    drawBone(lShoulder, lElbow);
    drawBone(lElbow, lWrist);
    drawBone(rShoulder, rElbow);
    drawBone(rElbow, rWrist);

    // Legs
    drawBone(lHip, lKnee);
    drawBone(lKnee, lAnkle);
    drawBone(rHip, rKnee);
    drawBone(rKnee, rAnkle);

    // Glowing Joint Nodes
    final joints = [
      neck,
      lShoulder,
      rShoulder,
      chest,
      waist,
      lHip,
      rHip,
      lKnee,
      rKnee,
      lAnkle,
      rAnkle,
    ];

    for (final j in joints) {
      canvas.drawCircle(j, 3.5, jointPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _AvatarWireframePainter oldDelegate) =>
      oldDelegate.rotationAngle != rotationAngle;
}
