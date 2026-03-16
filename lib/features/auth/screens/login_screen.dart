import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../core/assets/app_strings.dart';
import '../../../core/firebase/firebase_utils.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../home/screens/home_screen.dart';
import 'register_screen.dart';
import 'widgets/google_login_button.dart';
import 'widgets/login_header.dart';
import 'widgets/login_logo.dart';
import 'widgets/or_divider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 28),
                  const LoginLogo(),
                  const SizedBox(height: 28),
                  const LoginHeader(),
                  const SizedBox(height: 24),
                  CustomTextField(
                    controller: emailController,
                    hintText: AppStrings.emailHint,
                    prefixIcon: Icons.email_outlined,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: passwordController,
                    hintText: AppStrings.passwordHint,
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
                    suffixIcon: const Icon(Icons.visibility_off_outlined, color: AppColors.grey),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        AppStrings.forgetPassword,
                        style: AppStyles.linkPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(color: AppColors.white)
                          : const Text(
                              AppStrings.loginTitle,
                              style: AppStyles.buttonWhite,
                            ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        AppStrings.dontHaveAccount,
                        style: TextStyle(fontSize: 16, color: AppColors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterScreen.routeName);
                        },
                        child: const Text(
                          AppStrings.signup,
                          style: AppStyles.linkPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const OrDivider(),
                  const SizedBox(height: 24),
                  GoogleLoginButton(onTap: () {}),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    if (_formKey.currentState?.validate() == true) {
      setState(() {
        isLoading = true;
      });
      try {
        await FirebaseUtils.login(
          emailController.text,
          passwordController.text,
        );
        if (mounted) {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        }
      } on FirebaseAuthException catch (_) {
        String message = 'Invalid email or password';
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }
}
