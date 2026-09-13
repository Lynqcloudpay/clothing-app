import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/theme/app_colors.dart';
import '../../config/theme/app_spacing.dart';

/// A shimmering skeleton placeholder for loading states.
///
/// Uses the [shimmer] package with the app's dark card color palette.
/// Drop this in wherever content hasn't loaded yet.
///
/// ```dart
/// ShimmerLoader(width: 120, height: 16)
/// ```
class ShimmerLoader extends StatelessWidget {
  const ShimmerLoader({
    super.key,
    this.width,
    this.height,
    this.borderRadius = AppSpacing.borderRadiusMd,
    this.child,
  });

  /// Fixed width. If null, expands to parent.
  final double? width;

  /// Fixed height. If null, expands to parent.
  final double? height;

  /// Corner radius of the shimmering box.
  final double borderRadius;

  /// Optional custom child to shimmer over. If null, renders a
  /// plain rounded rectangle.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.backgroundCard,
      highlightColor: AppColors.backgroundElevated,
      child: child ??
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: AppColors.backgroundCard,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
    );
  }
}

/// A full-card shimmer skeleton matching a typical content card layout.
///
/// Shows a large image placeholder on top and two text-line placeholders
/// below. Great for feed / list loading states.
class ShimmerCardLoader extends StatelessWidget {
  const ShimmerCardLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.backgroundCard,
      highlightColor: AppColors.backgroundElevated,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.backgroundCard,
                borderRadius: BorderRadius.circular(AppSpacing.borderRadiusLg),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            // Title placeholder
            Container(
              width: 180,
              height: 16,
              decoration: BoxDecoration(
                color: AppColors.backgroundCard,
                borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSm),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            // Subtitle placeholder
            Container(
              width: 120,
              height: 12,
              decoration: BoxDecoration(
                color: AppColors.backgroundCard,
                borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSm),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
