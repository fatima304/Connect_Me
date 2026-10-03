import 'package:connectme_app/core/constants/app_colors.dart';
import 'package:connectme_app/core/constants/app_images.dart';
import 'package:connectme_app/core/helper/validator.dart';
import 'package:connectme_app/core/style/app_text_styles.dart';
import 'package:connectme_app/features/auth/presentation/screens/auth_screen.dart';
import 'package:connectme_app/features/auth/presentation/screens/signup_screen.dart';
import 'package:connectme_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:connectme_app/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:connectme_app/features/auth/presentation/widgets/social_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 20,
        children: [
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
          Text(
            'Forgot Password?',
            style: AppTextStyles.textStyle16DarkGreyRegular.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          CustomButton(text: 'Login', onPressed: () {}),
          Text(
            'or login by',
            style: AppTextStyles.textStyle16DarkGreyRegular.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SocialWidget(img: AppImages.google),
              SocialWidget(img: AppImages.facebook),
            ],
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Don\'t have an account? ',
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
                              AuthScreen(authSection: SignUpScreen()),
                        ),
                      );
                    },
                  text: 'Sign Up',
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
