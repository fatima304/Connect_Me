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
  void loadPosts() {
    emit(PostLoading());

    // Subscribe to the posts stream
    _postsSubscription = _getPosts().listen(
      (posts) {
        emit(PostLoaded(posts));
      },
      onError: (error) {
        emit(PostError(error.toString()));
      },
    );
  }

  // Creates a new post

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
