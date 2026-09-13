import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../config/routes/app_router.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_spacing.dart';
import '../../../config/theme/app_typography.dart';
import '../../../config/constants/app_strings.dart';

/// Initial splash screen with fade-in logo, app name, and tagline.
///
/// Auto-navigates to [RoutePaths.onboarding] after 2.5 seconds.
/// TODO: Add logic to skip onboarding if user is already authenticated.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    if (mounted) {
      // TODO: Check auth state and navigate to /feed if authenticated
      context.go(RoutePaths.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logo icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: AppColors.gradientPrimary,
                borderRadius: BorderRadius.circular(AppSpacing.borderRadiusXl),
              ),
              child: const Icon(
                Icons.auto_awesome,
                color: AppColors.backgroundPrimary,
                size: 40,
              ),
            )
                .animate()
                .fadeIn(duration: 500.ms)
                .scale(
                  begin: const Offset(0.8, 0.8),
                  end: const Offset(1.0, 1.0),
                  duration: 300.ms,
                  delay: 200.ms,
                  curve: Curves.easeOutBack,
                ),

            const SizedBox(height: AppSpacing.lg),

            // App name
            Text(
              AppStrings.appName,
              style: AppTypography.displayLarge.copyWith(
                color: AppColors.primaryGold,
              ),
            )
                .animate()
                .fadeIn(duration: 500.ms, delay: 400.ms),

            const SizedBox(height: AppSpacing.sm),

            // Tagline
            Text(
              AppStrings.appTagline,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            )
                .animate()
                .fadeIn(duration: 500.ms, delay: 600.ms),
          ],
        ),
      ),
    );
  }
}
