import 'package:connectme_app/core/errors/failures.dart';
import 'package:connectme_app/domain/entities/post.dart';
import 'package:dartz/dartz.dart';

// Repository interface for post operations
// Following Clean Architecture, this defines the contract that the data layer must implement
abstract class PostRepository {
  // Returns a stream of posts for real-time updates
  Stream<List<Post>> getPosts();

  // Creates a new post and returns the result
  Future<Either<Failure, void>> createPost({
    required String authorName,
    required String content,
  });
}
