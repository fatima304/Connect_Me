import 'package:connectme_app/core/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:connectme_app/core/constants/app_colors.dart';
import 'package:connectme_app/core/style/app_text_styles.dart';
import 'package:connectme_app/core/style/app_font_weight.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.userName,
    required this.userAvatar,
    required this.timeAgo,
    required this.postImage,
    required this.commentsCount,
    required this.likesCount,
  });

  final String userName;
  final String userAvatar;
  final String timeAgo;
  final String postImage;
  final int commentsCount;
  final int likesCount;

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
                userAvatar.isNotEmpty
                    ? CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(userAvatar),
                        onBackgroundImageError: (exception, stackTrace) {},
                      )
                    : CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.fieldBackground,
                        child: const Icon(
                          Icons.person,
                          color: AppColors.textGrey,
                          size: 24,
                        ),
                      ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: AppTextStyles.body.copyWith(
                          fontWeight: AppFontWeight.semiBold,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(timeAgo, style: AppTextStyles.caption),
              ],
            ),
          ),
          // Post image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
            child: postImage.isNotEmpty
                ? Image.asset(
                    postImage,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: 300,
                        color: AppColors.fieldBackground,
                        child: const Center(
                          child: Icon(
                            Icons.image,
                            size: 64,
                            color: AppColors.textGrey,
                          ),
                        ),
                      );
                    },
                  )
                : Container(
                    width: double.infinity,
                    height: 300,
                    color: AppColors.fieldBackground,
                    child: const Center(
                      child: Icon(
                        Icons.image,
                        size: 64,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ),
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
                Spacer(),
                Row(
                  children: [
                    Text(
                      commentsCount.toString(),
                      style: AppTextStyles.smallBody,
                    ),
                    const SizedBox(width: 4),
                    Image.asset(AppImages.comment, width: 20, height: 20),
                  ],
                ),
                const SizedBox(width: 16),
                Row(
                  children: [
                    Text(likesCount.toString(), style: AppTextStyles.smallBody),
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
