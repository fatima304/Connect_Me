import 'package:connectme_app/core/constants/app_colors.dart';
import 'package:connectme_app/core/helper/validator.dart';
import 'package:connectme_app/core/style/app_text_styles.dart';
import 'package:connectme_app/features/auth/presentation/screens/auth_screen.dart';
import 'package:connectme_app/features/auth/presentation/screens/login_screen.dart';
import 'package:connectme_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:connectme_app/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 20,
        children: [
          CustomTextFormField(
            controller: fullNameController,
            hintText: 'Full Name',
            validator: AuthValidators.fullName,
          ),
          CustomTextFormField(
            controller: emailController,
            hintText: 'Email',
            validator: AuthValidators.email,
          ),
          CustomTextFormField(
            controller: passwordController,
            hintText: 'Password',
            validator: AuthValidators.password,
          ),
          CustomTextFormField(
            controller: confirmPasswordController,
            hintText: 'Confirm Password',
            validator: (value) =>
                AuthValidators.confirmPassword(value, passwordController.text),
          ),
          CustomButton(text: 'Sign Up', onPressed: () {}),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Already have an account? ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AuthScreen(authSection: LoginScreen()),
                        ),
                      );
                    },
                  text: 'Login',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
