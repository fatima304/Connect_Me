import 'package:flutter/material.dart';
import 'package:connectme_app/core/routes/routes.dart';
import 'package:connectme_app/presentation/screens/auth_screen.dart';
import 'package:connectme_app/presentation/screens/home_screen.dart';
import 'package:connectme_app/presentation/screens/login_screen.dart';
import 'package:connectme_app/presentation/screens/signup_screen.dart';
import 'package:connectme_app/presentation/screens/profile_screen.dart';
import 'package:connectme_app/presentation/screens/map_screen.dart';

/// Centralized routing configuration for the application
/// Handles all route definitions and navigation logic
class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => const AuthScreen(authSection: LoginScreen()),
        );
      case Routes.signup:
        return MaterialPageRoute(
          builder: (_) => const AuthScreen(authSection: SignUpScreen()),
        );
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case Routes.profile:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );
      case Routes.map:
        return MaterialPageRoute(
          builder: (_) => const CommunityMapScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
