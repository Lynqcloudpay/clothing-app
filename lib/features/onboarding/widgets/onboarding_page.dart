import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_spacing.dart';
import '../../../config/theme/app_typography.dart';

/// Data class for a single onboarding page.
class OnboardingPageData {
  const OnboardingPageData({
    required this.icon,
    required this.gradientColors,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final List<Color> gradientColors;
  final String title;
  final String subtitle;
}

/// A single onboarding page with a gradient illustration area, title,
/// and subtitle.
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key, required this.data});

  final OnboardingPageData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        children: [
          const Spacer(flex: 1),

          // ── Illustration area (55% of remaining height) ──────
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: data.gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(AppSpacing.borderRadiusXl),
              ),
              child: Center(
                child: Icon(
                  data.icon,
                  size: 96,
                  color: AppColors.primaryGold.withValues(alpha: 0.7),
                ),
              ),
            )
                .animate()
                .fadeIn(duration: 500.ms)
                .slideY(begin: 0.05, end: 0, duration: 500.ms),
          ),

          const Spacer(flex: 1),

          // ── Title ────────────────────────────────────────────
          Text(
            data.title,
            style: AppTypography.headlineLarge,
            textAlign: TextAlign.center,
          )
              .animate()
              .fadeIn(duration: 400.ms, delay: 200.ms),

          const SizedBox(height: AppSpacing.md),

          // ── Subtitle ─────────────────────────────────────────
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 280),
            child: Text(
              data.subtitle,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          )
              .animate()
              .fadeIn(duration: 400.ms, delay: 350.ms),

          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
