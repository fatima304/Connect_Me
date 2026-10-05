import 'package:flutter/material.dart';
import 'package:connectme_app/core/constants/app_colors.dart';
import 'package:connectme_app/core/constants/app_images.dart';
import 'package:connectme_app/presentation/widgets/bottom_navigation_bar.dart';
import 'package:connectme_app/presentation/widgets/category_tabs.dart';
import 'package:connectme_app/presentation/widgets/home_search_bar.dart';
import 'package:connectme_app/presentation/widgets/post_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  String _selectedCategory = 'Popular';

  final List<String> _categories = ['Popular', 'Trending', 'Following'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top section with search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const Expanded(child: HomeSearchBar()),
                  const SizedBox(width: 12),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Image.asset(AppImages.send, width: 24, height: 24),
                  ),
                ],
              ),
            ),
            // Category tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CategoryTabs(
                categories: _categories,
                selectedCategory: _selectedCategory,
                onCategorySelected: (category) {
                  setState(() {
                    _selectedCategory = category;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            // Feed
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  PostCard(
                    userName: 'Thanh Pham',
                    userAvatar: '',
                    timeAgo: '1 hour ago',
                    postImage: '',
                    commentsCount: 20,
                    likesCount: 125,
                  ),
                  PostCard(
                    userName: 'Bruno',
                    userAvatar: '',
                    timeAgo: '1 hour ago',
                    postImage: '',
                    commentsCount: 15,
                    likesCount: 89,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Bottom navigation bar
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: _currentIndex,
        onItemTapped: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        onFabTapped: () {},
      ),
    );
  }
}
