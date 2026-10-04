// Authentication states for the AuthCubit
// Following the BLoC pattern, these states represent the different
// authentication states the UI can respond to
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthError extends AuthState {
  AuthError(this.message);

  final String message;
}
