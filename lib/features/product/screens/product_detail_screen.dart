import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_spacing.dart';
import '../../../config/theme/app_typography.dart';
import '../widgets/product_image_gallery.dart';
import '../widgets/size_recommendation_card.dart';
import '../widgets/purchase_button.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProductImageGallery(),
            
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Brand Name', style: AppTypography.titleMedium),
                      Text('\$129', style: AppTypography.headlineSmall.copyWith(color: AppColors.primaryGold)),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  const Text('Oversized Wool Blend Blazer', style: AppTypography.headlineMedium),
                  
                  const SizedBox(height: AppSpacing.xl),
                  
                  const SizeRecommendationCard(),
                  
                  const SizedBox(height: AppSpacing.xl),
                  
                  const Text('Description', style: AppTypography.titleMedium),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'A versatile, oversized blazer crafted from a premium wool blend. Features sharp lapels, strong shoulders, and a draped fit perfect for layering.',
                    style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
                  ),
                  
                  const SizedBox(height: AppSpacing.xxl),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: PurchaseButton(
            price: 129.0,
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
