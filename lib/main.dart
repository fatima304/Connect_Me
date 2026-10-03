import 'package:connectme_app/features/auth/presentation/screens/auth_screen.dart';
import 'package:connectme_app/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: AuthScreen(authSection: LoginScreen()),
      debugShowCheckedModeBanner: false,
    );
  }
}
