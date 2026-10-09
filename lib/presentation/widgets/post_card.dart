import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:connectme_app/core/constants/app_colors.dart';
import 'package:connectme_app/core/constants/app_images.dart';
import 'package:connectme_app/core/helper/injection.dart';
import 'package:connectme_app/core/style/app_font_weight.dart';
import 'package:connectme_app/core/style/app_text_styles.dart';
import 'package:connectme_app/data/datasources/profile_image_data_source.dart';
import 'package:connectme_app/domain/entities/post.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});

  final Post post;

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }

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

FutureBuilder<String?>(
  future: () async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null ||
        post.authorId.isEmpty ||
        post.authorId != user.uid) {
      return null;
    }

    return getIt<ProfileImageDataSource>()
        .getSavedImagePath(user.uid);
  }(),
  builder: (context, snapshot) {
    final path = snapshot.data;
    final hasImage = path != null && File(path).existsSync();

    return CircleAvatar(
      radius: 20,
      backgroundColor: AppColors.fieldBackground,
      backgroundImage: hasImage ? FileImage(File(path)) : null,
      child: hasImage
          ? null
          : const Icon(
              Icons.person,
              color: AppColors.textGrey,
              size: 24,
            ),
    );
  },
),

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
                Text(_getTimeAgo(post.createdAt), style: AppTextStyles.caption),
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
