import 'package:connectme_app/core/constants/app_images.dart';
import 'package:connectme_app/core/helper/injection.dart';
import 'package:connectme_app/presentation/blocs/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key, required this.authSection});

  final Widget authSection;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthCubit>(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                // Top image
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: Image.asset(
                    AppImages.authBackground,
                    fit: BoxFit.cover,
                  ),
                ),

                // White content container
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.40,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 30,
                    ),
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.60,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: authSection,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
