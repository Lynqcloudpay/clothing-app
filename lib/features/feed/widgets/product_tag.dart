import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_typography.dart';
import '../../../core/widgets/glass_card.dart';

class ProductTag extends StatelessWidget {
  final String label;
  final String price;
  final VoidCallback onTap;

  const ProductTag({
    super.key,
    required this.label,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        borderRadius: 20,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.primaryGold,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTypography.labelMedium),
                Text(price, style: AppTypography.labelSmall.copyWith(color: AppColors.textSecondary)),
              ],
            ),
            const SizedBox(width: 4),
            const Icon(Icons.chevron_right_rounded, color: Colors.white54, size: 16),
          ],
        ),
      ),
    );
  }
}
