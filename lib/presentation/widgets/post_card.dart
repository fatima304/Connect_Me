import 'package:flutter/material.dart';
import 'package:connectme_app/core/constants/app_colors.dart';
import 'package:connectme_app/core/constants/app_images.dart';
import 'package:connectme_app/core/helpers/time_formatter.dart';
import 'package:connectme_app/core/style/app_font_weight.dart';
import 'package:connectme_app/core/style/app_text_styles.dart';
import 'package:connectme_app/domain/entities/post.dart';
import 'package:connectme_app/presentation/widgets/post_author_avatar.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User info
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                PostAuthorAvatar(authorId: post.authorId),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.authorName,
                        style: AppTextStyles.body.copyWith(
                          fontWeight: AppFontWeight.semiBold,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  TimeFormatter.getTimeAgo(post.createdAt),
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          // Post content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(post.content, style: AppTextStyles.body),
          ),
          // Action buttons
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Image.asset(
                  AppImages.plus,
                  width: 20,
                  height: 20,
                  color: AppColors.primaryColor,
                ),
                const Spacer(),
                Row(
                  children: [
                    const Text('0', style: AppTextStyles.smallBody),
                    const SizedBox(width: 4),
                    Image.asset(AppImages.comment, width: 20, height: 20),
                  ],
                ),
                const SizedBox(width: 16),
                Row(
                  children: [
                    const Text('0', style: AppTextStyles.smallBody),
                    const SizedBox(width: 4),
                    Image.asset(AppImages.heart, width: 20, height: 20),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
