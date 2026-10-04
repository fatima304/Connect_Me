// AuthWrapper checks authentication state on app startup
// If user is already signed in, skip login screen and go to Home
// This implements the auth state persistence requirement
import 'package:connectme_app/presentation/screens/auth_screen.dart';
import 'package:connectme_app/presentation/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
          // TODO: Replace with actual HomeScreen when implemented
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Home Screen'),
                  Text('(To be implemented)'),
                ],
              ),
            ),
          );
        }

        // User is not signed in, show Login Screen
        return const AuthScreen(authSection: LoginScreen());
      },
    );
  }
}
