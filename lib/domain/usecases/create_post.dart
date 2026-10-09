
import 'package:connectme_app/core/errors/failures.dart';
import 'package:connectme_app/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';

class CreatePost {
  CreatePost(this._repository);

  final PostRepository _repository;

  Future<Either<Failure, void>> call({
    required String authorId,
    required String authorName,
    required String content,
  }) {
    return _repository.createPost(
      authorId: authorId,
      authorName: authorName,
      content: content,
    );
  }
}