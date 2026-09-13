import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/filter_options.dart';

class FilterNotifier extends StateNotifier<FilterOptions> {
  FilterNotifier() : super(const FilterOptions());

  void updateFilters(FilterOptions newOptions) {
    state = newOptions;
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, FilterOptions>((ref) {
  return FilterNotifier();
});
