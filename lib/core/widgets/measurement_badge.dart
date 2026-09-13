import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_typography.dart';

class MeasurementBadge extends StatelessWidget {
  final String label;

  const MeasurementBadge({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.backgroundElevated,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.surfaceBorder),
      ),
      child: Text(
        label,
        style: AppTypography.bodySmall,
      ),
    );
  }
}
