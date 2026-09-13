import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../config/theme/app_colors.dart';

/// A dot-based page indicator using [SmoothPageIndicator].
///
/// This is a thin convenience wrapper so the indicator style is
/// consistent everywhere it's used.
class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    required this.controller,
    required this.count,
  });

  final PageController controller;
  final int count;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: count,
      effect: ExpandingDotsEffect(
        activeDotColor: AppColors.primaryGold,
        dotColor: AppColors.textTertiary,
        dotHeight: 8,
        dotWidth: 8,
        expansionFactor: 3,
        spacing: 6,
      ),
    );
  }
}
