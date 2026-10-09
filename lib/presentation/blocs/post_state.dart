import 'package:connectme_app/domain/entities/post.dart';

// States for PostCubit
// Represents the different states of the posts feed
abstract class PostState {}

// Initial state before any action
class PostInitial extends PostState {}

// Loading state while fetching posts
class PostLoading extends PostState {}

// Loaded state with posts
class PostLoaded extends PostState {
  PostLoaded(this.posts);

  final List<Post> posts;
}

// Error state with a user-friendly message
class PostError extends PostState {
  PostError(this.message);

  final String message;
}

// State for creating a post
class PostCreating extends PostState {}

// State after successful post creation
class PostCreated extends PostState {}
