import 'package:flutter/material.dart';
import 'package:connectme_app/core/constants/app_colors.dart';

/// Reusable navigation item widget for bottom navigation bar
/// Uses image assets for custom icon styling
class NavItem extends StatelessWidget {
  const NavItem({
    super.key,
    required this.image,
    required this.isSelected,
    required this.onTap,
  });

  final String image;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
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

/// Navigation item widget that uses an icon instead of an image
class IconNavItem extends StatelessWidget {
  const IconNavItem({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        size: 26,
        color: isSelected ? AppColors.primaryColor : AppColors.textGrey,
      ),
    );
  }
}
