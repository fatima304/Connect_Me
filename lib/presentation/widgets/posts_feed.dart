import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:connectme_app/core/constants/app_colors.dart';
import 'package:connectme_app/core/style/app_text_styles.dart';
import 'package:connectme_app/presentation/blocs/post_cubit.dart';
import 'package:connectme_app/presentation/blocs/post_state.dart';
import 'package:connectme_app/presentation/widgets/post_card.dart';

/// Widget that displays the community posts feed
/// Handles loading, empty, error, and loaded states
class PostsFeed extends StatelessWidget {
  const PostsFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        if (state is PostLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is PostError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 48,
                  color: AppColors.textGrey,
                ),
                const SizedBox(height: 16),
                Text(
                  state.message,
                  style: AppTextStyles.body,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<PostCubit>().loadPosts();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state is PostLoaded) {
          if (state.posts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.feed_outlined,
                    size: 64,
                    color: AppColors.textGrey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No posts yet',
                    style: AppTextStyles.body,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Be the first to share something!',
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              return PostCard(
                post: state.posts[index],
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
