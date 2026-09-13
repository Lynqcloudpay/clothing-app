import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_typography.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      tileColor: AppColors.backgroundElevated,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.primaryGold.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.primaryGold),
      ),
      title: Text(title, style: AppTypography.titleMedium),
      subtitle: Text(subtitle, style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
      trailing: const Icon(Icons.chevron_right_rounded, color: Colors.white54),
      onTap: onTap,
    );
  }
}
