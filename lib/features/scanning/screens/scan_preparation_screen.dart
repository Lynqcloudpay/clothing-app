import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../config/routes/app_router.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_spacing.dart';
import '../../../config/theme/app_typography.dart';
import '../../../config/constants/app_strings.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/gradient_button.dart';

class ScanPreparationScreen extends StatelessWidget {
  const ScanPreparationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.scanPrepareTitle),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Animated Silhouette Preview ──────────────────
              Expanded(
                flex: 2,
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Placeholder for silhouette image
                      Icon(
                        Icons.accessibility_new_rounded,
                        size: 160,
                        color: AppColors.primaryGold.withValues(alpha: 0.2),
                      ),
                      // Scan pulse effect
                      Container(
                        width: 200,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.primaryGold,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryGold.withValues(alpha: 0.6),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      )
                          .animate(onPlay: (controller) => controller.repeat())
                          .slideY(
                            begin: -15.0,
                            end: 15.0,
                            duration: 2.seconds,
                            curve: Curves.easeInOut,
                          ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              // ── Instructions Checklist ───────────────────────
              Expanded(
                flex: 3,
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _InstructionCard(
                      icon: Icons.lightbulb_outline_rounded,
                      text: AppStrings.scanInstruction1,
                    ).animate().fadeIn(duration: 400.ms, delay: 100.ms)
                        .slideX(begin: -0.05, end: 0),
                    const SizedBox(height: AppSpacing.md),
                    _InstructionCard(
                      icon: Icons.checkroom_rounded,
                      text: AppStrings.scanInstruction2,
                    ).animate().fadeIn(duration: 400.ms, delay: 200.ms)
                        .slideX(begin: -0.05, end: 0),
                    const SizedBox(height: AppSpacing.md),
                    _InstructionCard(
                      icon: Icons.phone_android_rounded,
                      text: AppStrings.scanInstruction3,
                    ).animate().fadeIn(duration: 400.ms, delay: 300.ms)
                        .slideX(begin: -0.05, end: 0),
                    const SizedBox(height: AppSpacing.md),
                    _InstructionCard(
                      icon: Icons.threesixty_rounded,
                      text: AppStrings.scanInstruction4,
                    ).animate().fadeIn(duration: 400.ms, delay: 400.ms)
                        .slideX(begin: -0.05, end: 0),
                  ],
                ),
              ),

              // ── Start Button ─────────────────────────────────
              GradientButton(
                label: AppStrings.scanStartButton,
                onPressed: () => context.go(RoutePaths.scanCapture),
              ).animate().fadeIn(duration: 400.ms, delay: 500.ms),
              const SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
      ),
    );
  }
}

class _InstructionCard extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InstructionCard({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryGold, size: AppSpacing.iconMd),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              text,
              style: AppTypography.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
