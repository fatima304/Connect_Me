// AuthWrapper checks authentication state on app startup
// If user is already signed in, skip login screen and go to Home
// This implements the auth state persistence requirement
import 'package:connectme_app/core/helper/injection.dart';
import 'package:connectme_app/presentation/blocs/post_cubit.dart';
import 'package:connectme_app/presentation/screens/auth_screen.dart';
import 'package:connectme_app/presentation/screens/home_screen.dart';
import 'package:connectme_app/presentation/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          // User is signed in, navigate to Home Screen
          // BlocProvider provides PostCubit to HomeScreen and its children
          return BlocProvider(
            create: (context) => getIt<PostCubit>(),
            child: const HomeScreen(),
          );
        }

        // User is not signed in, show Login Screen
        return const AuthScreen(authSection: LoginScreen());
      },
    );
  }
}
