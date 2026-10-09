import 'package:connectme_app/core/errors/failures.dart';
import 'package:connectme_app/domain/entities/post.dart';
import 'package:dartz/dartz.dart';

abstract class PostRepository {
  Stream<List<Post>> getPosts();

  Future<Either<Failure, void>> createPost({
    required String authorId,
    required String authorName,
    required String content,
  });
}
