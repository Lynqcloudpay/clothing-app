import 'package:freezed_annotation/freezed_annotation.dart';

part 'size_chart.freezed.dart';
part 'size_chart.g.dart';

@freezed
class SizeChart with _$SizeChart {
  const factory SizeChart({
    required String brand,
    required String category,
    required String gender,
    required Map<String, SizeRange> sizes,
  }) = _SizeChart;

  factory SizeChart.fromJson(Map<String, dynamic> json) =>
      _$SizeChartFromJson(json);
}

@freezed
class SizeRange with _$SizeRange {
  const factory SizeRange({
    required double chestMin,
    required double chestMax,
    required double waistMin,
    required double waistMax,
    required double hipMin,
    required double hipMax,
  }) = _SizeRange;

  factory SizeRange.fromJson(Map<String, dynamic> json) =>
      _$SizeRangeFromJson(json);
}
