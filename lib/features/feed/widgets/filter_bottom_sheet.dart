import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_spacing.dart';
import '../../../config/theme/app_typography.dart';
import '../../../core/widgets/gradient_button.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.surfaceBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const Text('Filters', style: AppTypography.headlineSmall),
          const SizedBox(height: AppSpacing.lg),
          
          Expanded(
            child: ListView(
              children: [
                _FilterSection(
                  title: 'Occasion',
                  options: const ['Casual', 'Formal', 'Streetwear', 'Activewear'],
                ),
                const SizedBox(height: AppSpacing.lg),
                _FilterSection(
                  title: 'Category',
                  options: const ['Tops', 'Bottoms', 'Outerwear', 'Dresses'],
                ),
                const SizedBox(height: AppSpacing.lg),
                _FilterSection(
                  title: 'Price Range',
                  options: const ['\$', '\$\$', '\$\$\$', '\$\$\$\$'],
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Clear All', style: TextStyle(color: AppColors.textSecondary)),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                flex: 2,
                child: GradientButton(
                  label: 'Apply',
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FilterSection extends StatelessWidget {
  final String title;
  final List<String> options;

  const _FilterSection({required this.title, required this.options});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTypography.titleMedium),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((opt) => _FilterChip(label: opt)).toList(),
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;

  const _FilterChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.backgroundPrimary,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.surfaceBorder),
      ),
      child: Text(label, style: AppTypography.bodySmall),
    );
  }
}
