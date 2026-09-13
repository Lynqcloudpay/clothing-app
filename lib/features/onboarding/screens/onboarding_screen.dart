import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../config/routes/app_router.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_spacing.dart';
import '../../../config/theme/app_typography.dart';
import '../../../config/constants/app_strings.dart';
import '../../../core/widgets/gradient_button.dart';
import '../widgets/onboarding_page.dart';

/// Three-page onboarding carousel introducing the app's key features.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  static const _pages = [
    OnboardingPageData(
      icon: Icons.view_in_ar_rounded,
      gradientColors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
      title: AppStrings.onboardingTitle1,
      subtitle: AppStrings.onboardingSubtitle1,
    ),
    OnboardingPageData(
      icon: Icons.auto_awesome_rounded,
      gradientColors: [Color(0xFF1A1A2E), Color(0xFF0F3460)],
      title: AppStrings.onboardingTitle2,
      subtitle: AppStrings.onboardingSubtitle2,
    ),
    OnboardingPageData(
      icon: Icons.shopping_bag_rounded,
      gradientColors: [Color(0xFF1A1A2E), Color(0xFF533483)],
      title: AppStrings.onboardingTitle3,
      subtitle: AppStrings.onboardingSubtitle3,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _completeOnboarding() {
    context.go(RoutePaths.permissions);
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentPage == _pages.length - 1;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ── Skip button (pages 1–2 only) ─────────────────────
            Align(
              alignment: Alignment.topRight,
              child: AnimatedOpacity(
                opacity: isLastPage ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: TextButton(
                  onPressed: isLastPage ? null : _completeOnboarding,
                  child: Text(
                    AppStrings.onboardingSkip,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),

            // ── Page view ────────────────────────────────────────
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  return OnboardingPage(data: _pages[index]);
                },
              ),
            ),

            // ── Page indicator ───────────────────────────────────
            SmoothPageIndicator(
              controller: _pageController,
              count: _pages.length,
              effect: ExpandingDotsEffect(
                activeDotColor: AppColors.primaryGold,
                dotColor: AppColors.textTertiary,
                dotHeight: 8,
                dotWidth: 8,
                expansionFactor: 3,
                spacing: 6,
              ),
            ),

            const SizedBox(height: AppSpacing.xl),

            // ── CTA button ───────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
              ),
              child: isLastPage
                  ? GradientButton(
                      label: AppStrings.onboardingGetStarted,
                      onPressed: _completeOnboarding,
                    )
                  : TextButton(
                      onPressed: _goToNextPage,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            AppStrings.onboardingNext,
                            style: AppTypography.labelLarge.copyWith(
                              color: AppColors.primaryGold,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            color: AppColors.primaryGold,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
            ),

            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
