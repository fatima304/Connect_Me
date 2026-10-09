// Domain entity representing a post in the application
// Following Clean Architecture principles, entities are independent of frameworks
// and contain only business-level fields
class Post {
  final String id;
  final String authorName;
  final String content;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.authorName,
    required this.content,
    required this.createdAt,
  });
}
