import 'package:firebase_auth/firebase_auth.dart';

/// Wrapper service for Firebase Authentication.
class AuthService {
  // TODO: Replace with real FirebaseAuth injection when Firebase is configured
  // final FirebaseAuth _auth;
  // AuthService(this._auth);
  
  AuthService();

  Future<void> signInWithEmail(String email, String password) async {
    // await _auth.signInWithEmailAndPassword(email: email, password: password);
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> signUpWithEmail(String email, String password) async {
    // await _auth.createUserWithEmailAndPassword(email: email, password: password);
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> signInWithGoogle() async {
    // Google sign-in implementation
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> signInWithApple() async {
    // Apple sign-in implementation
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> signOut() async {
    // await _auth.signOut();
    await Future.delayed(const Duration(milliseconds: 500));
  }

  // Stream<User?> get authStateChanges => _auth.authStateChanges();
  Stream<User?> get authStateChanges => const Stream.empty();
}
