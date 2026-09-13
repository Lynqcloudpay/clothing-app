import 'dart:ui';

import 'package:flutter/material.dart';

import '../../config/theme/app_colors.dart';
import '../../config/theme/app_spacing.dart';

/// A frosted-glass card with a blurred background.
///
/// Uses [BackdropFilter] with a Gaussian blur to create the
/// glassmorphism effect. Wraps its [child] in a rounded container
/// with a semi-transparent white fill and a subtle border.
///
/// ```dart
/// GlassCard(
///   child: Text('Hello'),
///   onTap: () => print('tapped'),
/// )
/// ```
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.md),
    this.margin,
    this.onTap,
    this.borderRadius = AppSpacing.borderRadiusLg,
    this.blurSigma = 20.0,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final double borderRadius;
  final double blurSigma;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: blurSigma,
            sigmaY: blurSigma,
          ),
          child: Material(
            color: AppColors.surfaceGlass,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: BorderSide(color: AppColors.surfaceBorder),
            ),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(borderRadius),
              splashColor: AppColors.surfaceHover,
              highlightColor: Colors.transparent,
              child: Padding(
                padding: padding,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
