import 'package:connectme_app/core/constants/app_colors.dart';
import 'package:connectme_app/core/constants/app_images.dart';
import 'package:connectme_app/core/helper/injection.dart';
import 'package:connectme_app/core/helper/validator.dart';
import 'package:connectme_app/core/style/app_text_styles.dart';
import 'package:connectme_app/core/style/app_font_weight.dart';
import 'package:connectme_app/presentation/blocs/auth_cubit.dart';
import 'package:connectme_app/presentation/blocs/auth_state.dart';
import 'package:connectme_app/presentation/blocs/post_cubit.dart';
import 'package:connectme_app/presentation/screens/auth_screen.dart';
import 'package:connectme_app/presentation/screens/home_screen.dart';
import 'package:connectme_app/presentation/screens/signup_screen.dart';
import 'package:connectme_app/presentation/widgets/custom_button.dart';
import 'package:connectme_app/presentation/widgets/custom_text_form_field.dart';
import 'package:connectme_app/presentation/widgets/social_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          // Navigate to HomeScreen with PostCubit provider
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => getIt<PostCubit>(),
                child: const HomeScreen(),
              ),
            ),
          );
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Form(
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
            CustomButton(
              text: 'Login',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<AuthCubit>().login(
                    email: emailController.text.trim(),
                    password: passwordController.text,
                  );
                }
              },
            ),
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
                // Google button is static/non-functional for future implementation
                SocialWidget(img: AppImages.google),
                SocialWidget(img: AppImages.facebook),
              ],
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Don\'t have an account? ',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.darkGrey,
                    ),
                  ),
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const AuthScreen(authSection: SignUpScreen()),
                          ),
                        );
                      },
                    text: 'Sign Up',
                    style: AppTextStyles.link.copyWith(
                      fontWeight: AppFontWeight.semiBold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
