import 'package:connectme_app/core/errors/failures.dart';
import 'package:connectme_app/data/datasources/post_datasource_factory.dart';
import 'package:connectme_app/domain/entities/post.dart';
import 'package:connectme_app/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Implementation of PostRepository following Clean Architecture
// This data layer implementation depends on datasource abstractions
// Uses the Factory Pattern to select the appropriate datasource
class PostRepositoryImpl implements PostRepository {
  PostRepositoryImpl(this._dataSourceFactory);

  final PostDataSourceFactory _dataSourceFactory;

  @override
  Stream<List<Post>> getPosts() {
    // Use the remote Firestore datasource for real-time updates
    // The factory provides the appropriate datasource
    final remoteDataSource = _dataSourceFactory.getRemoteDataSource();

    return remoteDataSource
        .getPosts()
        .map((postModels) {
          // Convert PostModel to domain Post entity
          return postModels.map((model) => model.toEntity()).toList();
        })
        .handleError((error) {
          // Convert Firestore errors to domain failures
          throw _handleFirestoreError(error);
        });
  }

  @override

@override
Future<Either<Failure, void>> createPost({
  required String authorId,
  required String authorName,
  required String content,
}) async {
  try {
    final remoteDataSource =
        _dataSourceFactory.getRemoteDataSource();

    await remoteDataSource.createPost(
      authorId: authorId,
      authorName: authorName,
      content: content,
    );

    return const Right(null);
  } catch (error) {
    return Left(_handleFirestoreError(error));
  }
}
  // Handles Firestore errors and converts them to user-friendly failures
  Failure _handleFirestoreError(dynamic error) {
    // Handle specific Firestore error codes
    if (error is FirebaseException) {
      switch (error.code) {
        case 'permission-denied':
          return FirestoreFailure(
            'You do not have permission to perform this action.',
          );
        case 'not-found':
          return FirestoreFailure('The requested resource was not found.');
        case 'unavailable':
          return FirestoreFailure(
            'Service is currently unavailable. Please try again.',
          );
        case 'cancelled':
          return FirestoreFailure('The operation was cancelled.');
        default:
          return FirestoreFailure(
            'An error occurred: ${error.message ?? "Unknown error"}',
          );
      }
    }

    // Handle network errors
    if (error.toString().contains('network') ||
        error.toString().contains('connection')) {
      return NetworkFailure(
        'Network error. Please check your internet connection.',
      );
    }

    // Default error handling
    return FirestoreFailure('An unexpected error occurred. Please try again.');
  }
}
