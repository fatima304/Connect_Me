/// Domain entity representing a user in the application
/// Following Clean Architecture principles, entities are independent of frameworks
/// Note: Builder Pattern is applied during User model construction in UserModel.fromEntity
/// to ensure only fields provided during sign-up are set on the User model
class User {
  final String uid;
  final String fullName;
  final String email;
  final DateTime createdAt;

  User({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.createdAt,
  });
}
