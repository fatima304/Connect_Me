import 'package:connectme_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class SocialWidget extends StatelessWidget {
  const SocialWidget({super.key, required this.img});
  final String img;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: AppColors.lightGrey,
      child: Image.asset(img),
    );
  }
}
