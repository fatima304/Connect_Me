
import 'package:connectme_app/presentation/screens/map_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:connectme_app/core/constants/app_colors.dart';
import 'package:connectme_app/core/constants/app_images.dart';
import 'package:connectme_app/core/helper/injection.dart';
import 'package:connectme_app/core/style/app_text_styles.dart';

import 'package:connectme_app/presentation/blocs/biometric_cubit.dart';
import 'package:connectme_app/presentation/blocs/biometric_state.dart';
import 'package:connectme_app/presentation/blocs/post_cubit.dart';
import 'package:connectme_app/presentation/blocs/post_state.dart';

import 'package:connectme_app/presentation/screens/profile_screen.dart';

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

  final List<String> _categories = [
    'Popular',
    'Trending',
    'Following',
  ];

  final TextEditingController _postController = TextEditingController();

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  void _showCreatePostDialog() {
    final postCubit = context.read<PostCubit>();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Create Post'),
        content: TextField(
          controller: _postController,
          maxLines: 5,
          decoration: const InputDecoration(
            hintText: "What's on your mind?",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _postController.clear();
              Navigator.pop(dialogContext);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final content = _postController.text.trim();
              final user = FirebaseAuth.instance.currentUser;

              if (content.isEmpty || user == null) return;

              postCubit.createPost(
                authorId: user.uid,
                authorName: user.displayName ?? user.email ?? 'Anonymous',
                content: content,
              );

              _postController.clear();
              Navigator.pop(dialogContext);
            },
            child: const Text('Post'),
          ),
        ],
      ),
    );
  }

  void _onNavigationItemTapped(BuildContext context, int index) {
    if (index == 2) {
      context.read<BiometricCubit>().authenticate();
      return;
    }

    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BiometricCubit>(
      create: (_) => getIt<BiometricCubit>(),
      child: BlocListener<BiometricCubit, BiometricState>(
        listener: (context, state) {
          if (state.status == BiometricStatus.success) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ProfileScreen(),
              ),
            ).then((_) {
              if (mounted) {
                setState(() {
                  _currentIndex = 0;
                });
              }
            });
          } else if (state.status == BiometricStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage ?? 'Authentication failed.',
                ),
              ),
            );
          }
        },
        child: Builder(
          builder: (context) {
            return Scaffold(
              backgroundColor: AppColors.white,

              body: _currentIndex == 1
                  ? const CommunityMapScreen()
                  : SafeArea(
                      child: Column(
                        children: [
                          // Search bar
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: HomeSearchBar(),
                                ),
                                const SizedBox(width: 12),
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: AppColors.lightGrey,
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Image.asset(
                                    AppImages.send,
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Category tabs remain on Home
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
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

                          // Posts feed
                          Expanded(
                            child: BlocBuilder<PostCubit, PostState>(
                              builder: (context, state) {
                                if (state is PostLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                if (state is PostError) {
                                  return Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.error_outline,
                                          size: 48,
                                          color: AppColors.textGrey,
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          state.message,
                                          style: AppTextStyles.body,
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 16),
                                        ElevatedButton(
                                          onPressed: () {
                                            context
                                                .read<PostCubit>()
                                                .loadPosts();
                                          },
                                          child: const Text('Retry'),
                                        ),
                                      ],
                                    ),
                                  );
                                }

                                if (state is PostLoaded) {
                                  if (state.posts.isEmpty) {
                                    return Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.feed_outlined,
                                            size: 64,
                                            color: AppColors.textGrey,
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            'No posts yet',
                                            style: AppTextStyles.body,
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Be the first to share something!',
                                            style: AppTextStyles.caption,
                                          ),
                                        ],
                                      ),
                                    );
                                  }

                                  return ListView.builder(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    itemCount: state.posts.length,
                                    itemBuilder: (context, index) {
                                      return PostCard(
                                        post: state.posts[index],
                                      );
                                    },
                                  );
                                }

                                return const SizedBox.shrink();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

              bottomNavigationBar: BottomNavigationBarWidget(
                currentIndex: _currentIndex,
                onItemTapped: (index) {
                  _onNavigationItemTapped(context, index);
                },
                onFabTapped: _showCreatePostDialog,
              ),
            );
          },
        ),
      ),
    );
  }
}