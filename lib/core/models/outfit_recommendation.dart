import 'package:freezed_annotation/freezed_annotation.dart';

import 'clothing_item.dart';

part 'outfit_recommendation.freezed.dart';
part 'outfit_recommendation.g.dart';

@freezed
class OutfitRecommendation with _$OutfitRecommendation {
  const factory OutfitRecommendation({
    required String id,
    required List<ClothingItem> items,
    required double fitScore, // 0.0 - 1.0
    required double styleScore, // 0.0 - 1.0
    required String recommendationReason,
    required String bodyTypeAdvice,
    required String recommendedSize,
    required double totalPrice,
  }) = _OutfitRecommendation;

  factory OutfitRecommendation.fromJson(Map<String, dynamic> json) =>
      _$OutfitRecommendationFromJson(json);
}
