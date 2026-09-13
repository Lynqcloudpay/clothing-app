import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/routes/app_router.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_spacing.dart';
import '../../../config/theme/app_typography.dart';
import 'product_tag.dart';

class OutfitCard extends StatelessWidget {
  final int index;
  
  const OutfitCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background Video/Image
        Image.asset(
          'assets/images/mock_outfit_$index.jpg',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.grey[900],
            child: const Center(
              child: Icon(Icons.image, size: 100, color: Colors.white24),
            ),
          ),
        ),
        
        // Gradient Overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.3),
                Colors.transparent,
                Colors.black.withValues(alpha: 0.8),
              ],
            ),
          ),
        ),

        // Product Tags
        Positioned(
          left: 40,
          top: 300,
          child: ProductTag(
            label: 'Oversized Blazer',
            price: '\$129',
            onTap: () => context.go('${RoutePaths.feed}/product_123'),
          ),
        ),
        Positioned(
          right: 40,
          bottom: 250,
          child: ProductTag(
            label: 'Wide Leg Trousers',
            price: '\$89',
            onTap: () => context.go('${RoutePaths.feed}/product_124'),
          ),
        ),

        // Side Actions
        Positioned(
          right: AppSpacing.md,
          bottom: 100,
          child: Column(
            children: [
              _ActionButton(icon: Icons.favorite_border_rounded, label: '12k'),
              const SizedBox(height: AppSpacing.md),
              _ActionButton(icon: Icons.bookmark_border_rounded, label: 'Save'),
              const SizedBox(height: AppSpacing.md),
              _ActionButton(icon: Icons.share_rounded, label: 'Share'),
            ],
          ),
        ),

        // Bottom Info
        Positioned(
          left: AppSpacing.md,
          bottom: 100,
          right: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('@style_icon', style: AppTypography.titleMedium),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Minimalist autumn look. 🍂 Perfect for rectangle body types.',
                style: AppTypography.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryGold.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle, color: AppColors.primaryGold, size: 14),
                    const SizedBox(width: 4),
                    Text('98% Fit Match', style: AppTypography.labelMedium.copyWith(color: AppColors.primaryGold)),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.4),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        const SizedBox(height: 4),
        Text(label, style: AppTypography.labelSmall),
      ],
    );
  }
}
