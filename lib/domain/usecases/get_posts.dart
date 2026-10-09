import 'package:connectme_app/domain/entities/post.dart';
import 'package:connectme_app/domain/repositories/post_repository.dart';

// Use case for getting posts
// This encapsulates the business logic for retrieving posts
class GetPosts {
  GetPosts(this._repository);

  final PostRepository _repository;

  // Returns a stream of posts for real-time updates
  Stream<List<Post>> call() {
    return _repository.getPosts();
  }
}
