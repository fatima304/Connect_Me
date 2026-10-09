// Domain entity representing a user in the application
// Following Clean Architecture principles, entities are independent of frameworks
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
