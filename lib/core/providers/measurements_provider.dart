import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/body_measurements.dart';
import '../services/firestore_service.dart';
import 'auth_provider.dart';

final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  return FirestoreService();
});

final latestMeasurementsProvider = FutureProvider<BodyMeasurements?>((ref) async {
  final user = ref.watch(currentUserProvider).value;
  if (user == null) return null;

  final firestore = ref.watch(firestoreServiceProvider);
  return firestore.getLatestMeasurements(user.id);
});

final measurementHistoryProvider = FutureProvider<List<BodyMeasurements>>((ref) async {
  // Mock history for now
  return [];
});
