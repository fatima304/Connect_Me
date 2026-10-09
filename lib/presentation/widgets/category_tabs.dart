import 'package:flutter/material.dart';
import 'package:connectme_app/core/constants/app_colors.dart';
import 'package:connectme_app/core/style/app_text_styles.dart';

class CategoryTabs extends StatelessWidget {
  const CategoryTabs({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  final List<String> categories;
  final String selectedCategory;
  final Function(String) onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: categories.map((category) {
        final isSelected = category == selectedCategory;
        return Padding(
          padding: const EdgeInsets.only(right: 12),
          child: GestureDetector(
            onTap: () => onCategorySelected(category),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color:
                    isSelected ? AppColors.lightPurple : AppColors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                category,
                style: AppTextStyles.smallBody.copyWith(
                  color:
                      isSelected ? AppColors.primaryColor : AppColors.textGrey,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
