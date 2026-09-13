import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/outfit_recommendation.dart';

final recommendationsProvider = FutureProvider<List<OutfitRecommendation>>((ref) async {
  // TODO: Call cloud function getRecommendations
  await Future.delayed(const Duration(seconds: 1));
  return [];
});
