// Domain entity representing a user in the application
// Following Clean Architecture principles, entities are independent of frameworks
class User {
  final String fullName;
  final String email;

  User({
    required this.fullName,
    required this.email,
  });
}
