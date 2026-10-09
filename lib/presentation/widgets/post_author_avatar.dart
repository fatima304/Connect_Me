import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:connectme_app/core/constants/app_colors.dart';
import 'package:connectme_app/core/helper/injection.dart';
import 'package:connectme_app/data/datasources/profile_image_data_source.dart';

/// Widget that displays the author's avatar for a post
/// Shows the user's profile image if available, otherwise a default icon
class PostAuthorAvatar extends StatelessWidget {
  const PostAuthorAvatar({
    super.key,
    required this.authorId,
  });

  final String authorId;

  @override
  Widget build(BuildContext context) {
    // Show profile image if the post is from the current user
    if (authorId == FirebaseAuth.instance.currentUser?.uid) {
      return FutureBuilder<String?>(
        future: getIt<ProfileImageDataSource>().getSavedImagePath(authorId),
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
      );
    }

    // Default avatar for other users
    return CircleAvatar(
      radius: 20,
      backgroundColor: AppColors.fieldBackground,
      child: const Icon(
        Icons.person,
        color: AppColors.textGrey,
        size: 24,
      ),
    );
  }
}
