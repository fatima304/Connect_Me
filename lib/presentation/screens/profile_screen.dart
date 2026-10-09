import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:connectme_app/core/helper/injection.dart';
import 'package:connectme_app/presentation/blocs/auth_cubit.dart';
import 'package:connectme_app/presentation/blocs/auth_state.dart';
import 'package:connectme_app/presentation/blocs/device_info_cubit.dart';
import 'package:connectme_app/presentation/blocs/device_info_state.dart';
import 'package:connectme_app/presentation/blocs/profile_cubit.dart';
import 'package:connectme_app/presentation/blocs/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ProfileCubit>()..loadProfile()),
        BlocProvider(create: (_) => getIt<DeviceInfoCubit>()..getDeviceInfo()),
        BlocProvider(create: (_) => getIt<AuthCubit>()),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('My Profile'),
              centerTitle: true,
              actions: [
                IconButton(
                  tooltip: 'Log out',
                  icon: const Icon(Icons.logout),
                  onPressed: () async {
                    final shouldLogout = await showDialog<bool>(
                      context: context,
                      builder: (dialogContext) => AlertDialog(
                        title: const Text('Log out'),
                        content: const Text(
                          'Are you sure you want to log out?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(dialogContext, false);
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(dialogContext, true);
                            },
                            child: const Text('Log out'),
                          ),
                        ],
                      ),
                    );

                    if (shouldLogout != true || !context.mounted) {
                      return;
                    }

                    await context.read<AuthCubit>().logout();

                    if (!context.mounted) return;

                    final authState = context.read<AuthCubit>().state;

                    if (authState is AuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(authState.message)),
                      );
                    }
                  },
                ),
              ],
            ),
            body: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state.status == ProfileStatus.loading ||
                    state.status == ProfileStatus.initial) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.status == ProfileStatus.error) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            state.errorMessage ?? 'Something went wrong.',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {
                              context.read<ProfileCubit>().loadProfile();
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final photoPath = state.photoPath;
                final hasPhoto =
                    photoPath != null && File(photoPath).existsSync();

                return ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                key: ValueKey(photoPath),
                                radius: 60,
                                backgroundColor: Colors.grey.shade200,
                                backgroundImage: hasPhoto
                                    ? FileImage(File(photoPath))
                                    : null,
                                child: hasPhoto
                                    ? null
                                    : const Icon(
                                        Icons.person,
                                        size: 60,
                                        color: Colors.grey,
                                      ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: IconButton.filled(
                                  onPressed: () {
                                    context
                                        .read<ProfileCubit>()
                                        .changeProfileImage();
                                  },
                                  icon: const Icon(Icons.camera_alt),
                                  tooltip: 'Change profile photo',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            state.fullName.isEmpty ? 'User' : state.fullName,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(state.email),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.phone_android),
                      title: const Text('Device Model'),
                      subtitle: BlocBuilder<DeviceInfoCubit, DeviceInfoState>(
                        builder: (context, deviceState) {
                          if (deviceState.status == DeviceInfoStatus.loading) {
                            return const Text('Loading...');
                          }

                          if (deviceState.status == DeviceInfoStatus.success) {
                            return Text(
                              deviceState.deviceInfo?.modelName ?? 'Unknown',
                            );
                          }

                          return const Text('Unavailable');
                        },
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.system_update),
                      title: const Text('Operating System Version'),
                      subtitle: BlocBuilder<DeviceInfoCubit, DeviceInfoState>(
                        builder: (context, deviceState) {
                          if (deviceState.status == DeviceInfoStatus.loading) {
                            return const Text('Loading...');
                          }

                          if (deviceState.status == DeviceInfoStatus.success) {
                            return Text(
                              deviceState.deviceInfo?.osVersion ?? 'Unknown',
                            );
                          }

                          return const Text('Unavailable');
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
