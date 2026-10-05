import 'package:flutter/material.dart';
import 'package:connectme_app/core/constants/app_colors.dart';
import 'package:connectme_app/core/style/app_font_weight.dart';

class AppTextStyles {
  static const textStyle16DarkGreyRegular = TextStyle(
    fontSize: 16,
    color: AppColors.darkGrey,
    fontWeight: AppFontWeight.regular,
  );

  static const button = TextStyle(
    fontSize: 16,
    fontWeight: AppFontWeight.semiBold,
    color: AppColors.white,
  );

  static const body = TextStyle(
    fontSize: 16,
    fontWeight: AppFontWeight.regular,
    color: AppColors.textDark,
  );

  static const caption = TextStyle(
    fontSize: 12,
    fontWeight: AppFontWeight.regular,
    color: AppColors.textGrey,
  );

  static const smallBody = TextStyle(
    fontSize: 14,
    fontWeight: AppFontWeight.medium,
    color: AppColors.textDark,
  );

  static const link = TextStyle(
    fontSize: 14,
    fontWeight: AppFontWeight.regular,
    color: AppColors.primaryColor,
  );

  static const hint = TextStyle(
    fontSize: 16,
    fontWeight: AppFontWeight.regular,
    color: AppColors.textGrey,
  );

  static const error = TextStyle(
    fontSize: 12,
    fontWeight: AppFontWeight.regular,
    color: AppColors.error,
  );
}
