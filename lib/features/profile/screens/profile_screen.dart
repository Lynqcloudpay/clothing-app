import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/routes/app_router.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_spacing.dart';
import '../../../config/theme/app_typography.dart';
import '../../../core/providers/auth_provider.dart';
import '../widgets/settings_tile.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider).value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            // User Header
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.primaryGold.withValues(alpha: 0.2),
                  backgroundImage: user?.photoUrl != null ? NetworkImage(user!.photoUrl!) : null,
                  child: user?.photoUrl == null ? const Icon(Icons.person, size: 40, color: AppColors.primaryGold) : null,
                ),
                const SizedBox(width: AppSpacing.lg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user?.displayName ?? 'Style Icon', style: AppTypography.headlineSmall),
                      Text(user?.email ?? '', style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary)),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: AppSpacing.xxl),

            // Profile Actions
            SettingsTile(
              icon: Icons.accessibility_new_rounded,
              title: 'My Body Profile & 3D Avatar',
              subtitle: 'View your latest scan and measurements',
              onTap: () => context.go(RoutePaths.bodyProfile),
            ),
            const SizedBox(height: AppSpacing.md),
            SettingsTile(
              icon: Icons.bookmark_border_rounded,
              title: 'Saved Looks',
              subtitle: 'Your bookmarked outfits and items',
              onTap: () {},
            ),
            const SizedBox(height: AppSpacing.md),
            SettingsTile(
              icon: Icons.history_rounded,
              title: 'Scan History',
              subtitle: 'Track your body measurements over time',
              onTap: () {},
            ),
            const SizedBox(height: AppSpacing.xxl),

            // Logout
            TextButton.icon(
              onPressed: () async {
                await ref.read(authServiceProvider).signOut();
              },
              icon: const Icon(Icons.logout, color: AppColors.accentWarning),
              label: Text('Sign Out', style: AppTypography.titleMedium.copyWith(color: AppColors.accentWarning)),
            )
          ],
        ),
      ),
    );
  }
}
