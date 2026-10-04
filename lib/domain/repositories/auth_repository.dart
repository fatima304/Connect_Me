import 'package:firebase_auth/firebase_auth.dart';

// Repository interface for authentication operations
// Following Clean Architecture, this defines the contract that the data layer must implement
abstract class AuthRepository {
  Future<UserCredential> login({
    required String email,
    required String password,
  });

  Future<UserCredential> signUp({
    required String fullName,
    required String email,
    required String password,
  });

  Future<void> logout();

  User? get currentUser;
}
