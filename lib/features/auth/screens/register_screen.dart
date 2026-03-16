import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../core/assets/app_strings.dart';
import '../../../core/firebase/firebase_utils.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../models/my_user.dart';
import 'login_screen.dart';
import 'widgets/register_fields.dart';
import 'widgets/register_logo.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(AppStrings.registerTitle),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const RegisterLogo(),
                  const SizedBox(height: 30),
                  RegisterFields(
                    nameController: nameController,
                    emailController: emailController,
                    passwordController: passwordController,
                    rePasswordController: rePasswordController,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(color: AppColors.white)
                          : const Text(
                              AppStrings.getStarted,
                              style: AppStyles.buttonWhite,
                            ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        AppStrings.alreadyHaveAccount,
                        style: TextStyle(fontSize: 16, color: AppColors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          AppStrings.loginTitle,
                          style: AppStyles.linkPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void register() async {
    if (_formKey.currentState?.validate() == true) {
      setState(() {
        isLoading = true;
      });
      try {
        var credential = await FirebaseUtils.register(
          emailController.text,
          passwordController.text,
        );

        MyUser myUser = MyUser(
          id: credential.user?.uid ?? '',
          name: nameController.text,
          email: emailController.text,
        );
        await FirebaseUtils.addUserToFirestore(myUser);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration Successful')),
          );
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        }
      } on FirebaseAuthException catch (e) {
        String message = 'Something went wrong';
        if (e.code == 'weak-password') {
          message = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          message = 'The account already exists for that email.';
        }
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
