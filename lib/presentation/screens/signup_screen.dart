import 'package:connectme_app/core/constants/app_colors.dart';
import 'package:connectme_app/core/helper/validator.dart';
import 'package:connectme_app/core/style/app_text_styles.dart';
import 'package:connectme_app/core/style/app_font_weight.dart';
import 'package:connectme_app/presentation/blocs/auth_cubit.dart';
import 'package:connectme_app/presentation/blocs/auth_state.dart';
import 'package:connectme_app/presentation/screens/auth_screen.dart';
import 'package:connectme_app/presentation/screens/home_screen.dart';
import 'package:connectme_app/presentation/screens/login_screen.dart';
import 'package:connectme_app/presentation/widgets/custom_button.dart';
import 'package:connectme_app/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController fullNameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
       
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
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
              validator: (value) => AuthValidators.confirmPassword(
                value,
                passwordController.text,
              ),
            ),
            CustomButton(
              text: 'Sign Up',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<AuthCubit>().signUp(
                    fullName: fullNameController.text.trim(),
                    email: emailController.text.trim(),
                    password: passwordController.text,
                  );
                }
              },
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Already have an account? ',
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
                                const AuthScreen(authSection: LoginScreen()),
                          ),
                        );
                      },
                    text: 'Login',
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
