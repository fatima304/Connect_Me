import 'dart:async';

import 'package:connectme_app/domain/entities/post.dart';
import 'package:connectme_app/domain/usecases/create_post.dart';
import 'package:connectme_app/domain/usecases/get_posts.dart';
import 'package:connectme_app/presentation/blocs/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Cubit for managing post state
// Handles loading, loaded, and error states for the posts feed
// Coordinates between GetPosts and CreatePost use cases
class PostCubit extends Cubit<PostState> {
  PostCubit(this._getPosts, this._createPost) : super(PostInitial()) {
    // Load posts when the cubit is created
    loadPosts();
  }

  final GetPosts _getPosts;
  final CreatePost _createPost;

  StreamSubscription<List<Post>>? _postsSubscription;

  // Loads posts from the real-time stream
  // Cancels any existing subscription to avoid duplicates
  void loadPosts() {
    emit(PostLoading());

    // Cancel existing subscription if present to avoid memory leaks
    _postsSubscription?.cancel();

    // Subscribe to the posts stream
    _postsSubscription = _getPosts().listen(
      (posts) {
        emit(PostLoaded(posts));
      },
      onError: (error) {
        // Convert error to user-friendly message
        final errorMessage = _getErrorMessage(error);
        emit(PostError(errorMessage));
      },
    );
  }

  // Convert errors to user-friendly messages
  String _getErrorMessage(dynamic error) {
    if (error.toString().contains('network') ||
        error.toString().contains('connection')) {
      return 'Network error. Please check your internet connection.';
    }
    if (error.toString().contains('permission')) {
      return 'You do not have permission to view posts.';
    }
    return 'Failed to load posts. Please try again.';
  }

  // Creates a new post and updates the feed
  // Emits creating state to show loading indicator
  Future<void> createPost({
    required String authorId,
    required String authorName,
    required String content,
  }) async {
    emit(PostCreating());

    final result = await _createPost(
      authorId: authorId,
      authorName: authorName,
      content: content,
    );

    result.fold(
      (failure) {
        emit(PostError(failure.message));
      },
      (_) {
        emit(PostCreated());

        Future.delayed(const Duration(milliseconds: 500), () {
          if (state is PostLoaded) {
            emit(state);
          }
        });
      },
    );
  }

  @override
  Future<void> close() {
    // Cancel the stream subscription to prevent memory leaks
    _postsSubscription?.cancel();
    return super.close();
  }
}
