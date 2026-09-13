import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import 'auth_provider.dart';

final userProfileProvider = Provider<UserModel?>((ref) {
  // Derives the user profile from the authenticated current user.
  // In a real app this might combine multiple sources or a dedicated snapshot stream.
  return ref.watch(currentUserProvider).value;
});
