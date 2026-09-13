import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_spacing.dart';
import '../../../config/theme/app_typography.dart';
import '../widgets/outfit_card.dart';
import '../widgets/filter_bottom_sheet.dart';

class StyleFeedScreen extends ConsumerStatefulWidget {
  const StyleFeedScreen({super.key});

  @override
  ConsumerState<StyleFeedScreen> createState() => _StyleFeedScreenState();
}

class _StyleFeedScreenState extends ConsumerState<StyleFeedScreen> {
  final PageController _pageController = PageController();

  void _openFilters() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.backgroundElevated,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => const FilterBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Mock data for feed
    final mockOutfits = [1, 2, 3, 4];

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'For You',
          style: AppTypography.titleLarge,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune_rounded),
            onPressed: _openFilters,
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: mockOutfits.length,
        itemBuilder: (context, index) {
          return OutfitCard(index: index);
        },
      ),
    );
  }
}
