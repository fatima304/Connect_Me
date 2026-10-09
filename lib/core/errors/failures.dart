// Failure classes for handling errors in the application
// Following Clean Architecture, failures represent domain-level errors
abstract class Failure {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}

class NetworkFailure extends Failure {
  NetworkFailure(super.message);
}

class ValidationFailure extends Failure {
  ValidationFailure(super.message);
}

class AuthenticationFailure extends Failure {
  AuthenticationFailure(super.message);
}

class FirestoreFailure extends Failure {
  FirestoreFailure(super.message);
}
