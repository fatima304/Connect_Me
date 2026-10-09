import 'package:connectme_app/data/models/post_model.dart';

// Local datasource for posts (cache)
// This represents a local cache abstraction for posts
// In a real app, this could use SharedPreferences, Hive, or SQLite
// For this assignment, we use a simple in-memory cache to demonstrate the pattern
class LocalPostDataSource {
  LocalPostDataSource();

  // In-memory cache for posts
  List<PostModel>? _cachedPosts;

  // Returns cached posts as a stream (for interface consistency)
  Stream<List<PostModel>> getPosts() {
    // Since this is a simple in-memory cache, we return a single-value stream
    // In a real implementation, this might emit from a local database
    final posts = _cachedPosts ?? [];
    return Stream.value(posts);
  }

  // Caches posts locally
  void cachePosts(List<PostModel> posts) {
    _cachedPosts = posts;
  }

  // Creates a post in the local cache

Future<void> createPost({
  required String authorId,
  required String authorName,
  required String content,
}) async {
  final newPost = PostModel(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    authorId: authorId,
    authorName: authorName,
    content: content,
    createdAt: DateTime.now(),
  );

  _cachedPosts = [...(_cachedPosts ?? []), newPost];
}

}
