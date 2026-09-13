import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_spacing.dart';
import '../../../config/theme/app_typography.dart';
import '../../../core/widgets/glass_card.dart';

class SizeRecommendationCard extends StatelessWidget {
  const SizeRecommendationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: AppColors.primaryGold, size: 20),
              const SizedBox(width: AppSpacing.sm),
              Text('Perfect Fit Recommended', style: AppTypography.titleMedium.copyWith(color: AppColors.primaryGold)),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Your Size', style: AppTypography.bodySmall),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primaryGold,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('M', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Based on your 3D scan, a size M will give you the desired oversized fit while fitting your shoulders perfectly.',
                    style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
