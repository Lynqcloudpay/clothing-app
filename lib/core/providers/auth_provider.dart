import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});

final currentUserProvider = FutureProvider<UserModel?>((ref) async {
  final user = ref.watch(authStateProvider).value;
  if (user == null) return null;
  
  // TODO: Fetch UserModel from Firestore using user.uid
  return UserModel(
    id: user.uid,
    email: user.email ?? '',
    displayName: user.displayName,
    createdAt: DateTime.now(),
  );
});
