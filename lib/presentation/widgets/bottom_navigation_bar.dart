import 'package:flutter/material.dart';
import 'package:connectme_app/core/constants/app_colors.dart';
import 'package:connectme_app/core/constants/app_images.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
    required this.onFabTapped,
  });

  final int currentIndex;
  final Function(int) onItemTapped;
  final VoidCallback onFabTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Navigation icons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem(
                  image: AppImages.home,
                  isSelected: currentIndex == 0,
                  onTap: () => onItemTapped(0),
                ),
                _buildNavItem(
                  image: AppImages.category,
                  isSelected: currentIndex == 1,
                  onTap: () => onItemTapped(1),
                ),
                const SizedBox(width: 56), // Space for FAB
                _buildNavItem(
                  image: AppImages.notification,
                  isSelected: currentIndex == 2,
                  onTap: () => onItemTapped(2),
                ),
                _buildNavItem(
                  image: AppImages.profile,
                  isSelected: currentIndex == 3,
                  onTap: () => onItemTapped(3),
                ),
              ],
            ),
          ),
          // Floating action button
          Positioned(
            left: 0,
            right: 0,
            top: -28,
            child: Center(
              child: GestureDetector(
                onTap: onFabTapped,
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryColor.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    AppImages.add,
                    width: 28,
                    height: 28,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required String image,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        image,
        width: 24,
        height: 24,
        color: isSelected ? AppColors.primaryColor : AppColors.textGrey,
      ),
    );
  }
}
