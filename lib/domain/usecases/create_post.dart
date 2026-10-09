import 'package:connectme_app/core/errors/failures.dart';
import 'package:connectme_app/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';

// Use case for creating a post
// This encapsulates the business logic for creating posts
class CreatePost {
  CreatePost(this._repository);

  final PostRepository _repository;

  // Creates a new post and returns the result
  Future<Either<Failure, void>> call({
    required String authorName,
    required String content,
  }) {
    return _repository.createPost(authorName: authorName, content: content);
  }
}
