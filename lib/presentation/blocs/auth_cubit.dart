import 'package:connectme_app/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_state.dart';

// Cubit pattern for managing authentication state
// Handles login, sign up, and logout operations with proper state management
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(AuthInitial());

  final AuthRepository _authRepository;

  // Convert Firebase exceptions to user-friendly messages
  String _getErrorMessage(dynamic error) {
    if (error is firebase_auth.FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
          return 'No user found with this email.';
        case 'wrong-password':
          return 'Incorrect password provided.';
        case 'email-already-in-use':
          return 'An account already exists with this email.';
        case 'invalid-email':
          return 'The email address is not valid.';
        case 'weak-password':
          return 'The password is too weak.';
        case 'user-disabled':
          return 'This user account has been disabled.';
        case 'too-many-requests':
          return 'Too many attempts. Please try again later.';
        default:
          return 'An authentication error occurred: ${error.message}';
      }
    }
    return 'An unexpected error occurred. Please try again.';
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());

    try {
      await _authRepository.login(email: email, password: password);

      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(_getErrorMessage(e)));
    }
  }

  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      await _authRepository.signUp(
        fullName: fullName,
        email: email,
        password: password,
      );

      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(_getErrorMessage(e)));
    }
  }

  Future<void> logout() async {
    try {
      await _authRepository.logout();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(_getErrorMessage(e)));
    }
  }
}
