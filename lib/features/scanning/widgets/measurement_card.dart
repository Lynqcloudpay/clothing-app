import 'package:flutter/material.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_spacing.dart';
import '../../../config/theme/app_typography.dart';

class MeasurementCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const MeasurementCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.primaryGold.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primaryGold, size: 20),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(label, style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
                Text(value, style: AppTypography.titleMedium),
              ],
            ),
          )
        ],
      ),
    );
  }
}
