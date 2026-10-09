import 'package:connectme_app/domain/repositories/auth_repository.dart';
import 'package:connectme_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Implementation of AuthRepository following Clean Architecture
// This data layer implementation depends on the service layer
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._authService);

  final AuthService _authService;

  @override
  Future<UserCredential> login({
    required String email,
    required String password,
  }) {
    return _authService.login(email: email, password: password);
  }

  @override
  Future<UserCredential> signUp({
    required String fullName,
    required String email,
    required String password,
  }) {
    return _authService.signUp(
      email: email,
      password: password,
      fullName: fullName,
    );
  }

  @override
  Future<void> logout() {
    return _authService.logout();
  }

  @override
  User? get currentUser => _authService.currentUser;
}
