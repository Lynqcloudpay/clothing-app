import 'package:flutter/material.dart';

import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_spacing.dart';
import '../../../config/theme/app_typography.dart';

/// An outlined social login button (Google, Apple, etc.).
class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        side: BorderSide(color: AppColors.surfaceBorder),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMd),
        ),
        minimumSize: const Size(0, AppSpacing.buttonHeight),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: AppSpacing.sm),
          Text(label, style: AppTypography.bodyMedium),
        ],
      ),
    );
  }
}
