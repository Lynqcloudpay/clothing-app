import 'package:freezed_annotation/freezed_annotation.dart';

part 'clothing_item.freezed.dart';
part 'clothing_item.g.dart';

@freezed
class ClothingItem with _$ClothingItem {
  const factory ClothingItem({
    required String id,
    required String name,
    required String brand,
    required String description,
    required double price,
    required String currency,
    required String imageUrl,
    @Default([]) List<String> additionalImages,
    required String category, // "tops", "bottoms", "outerwear", "footwear", "accessories"
    required String occasion, // "casual", "formal", "activewear", "streetwear"
    required String color,
    required String pattern,
    required String affiliateUrl,
    required String retailer,
    @Default({}) Map<String, String> availableSizes, // e.g. {"S": "in_stock"}
    @Default(0.0) double trendScore,
    required DateTime trendTimestamp,
  }) = _ClothingItem;

  factory ClothingItem.fromJson(Map<String, dynamic> json) =>
      _$ClothingItemFromJson(json);
}
