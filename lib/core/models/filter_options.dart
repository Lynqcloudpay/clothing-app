import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter_options.freezed.dart';
part 'filter_options.g.dart';

@freezed
class FilterOptions with _$FilterOptions {
  const factory FilterOptions({
    double? minBudget,
    double? maxBudget,
    @Default([]) List<String> occasions,
    @Default([]) List<String> categories,
    @Default([]) List<String> preferredBrands,
    @Default([]) List<String> preferredColors,
    @Default('trending') String sortBy,
  }) = _FilterOptions;

  factory FilterOptions.fromJson(Map<String, dynamic> json) =>
      _$FilterOptionsFromJson(json);
}
