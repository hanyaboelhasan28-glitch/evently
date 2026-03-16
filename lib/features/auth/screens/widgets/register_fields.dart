import 'package:flutter/material.dart';
import '../../../../core/assets/app_strings.dart';
import '../../../../core/widgets/custom_text_field.dart';

class RegisterFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController rePasswordController;

  const RegisterFields({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.rePasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: nameController,
          hintText: AppStrings.nameHint,
          prefixIcon: Icons.person_outline,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
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
          suffixIcon: const Icon(Icons.visibility_off_outlined),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: rePasswordController,
          hintText: AppStrings.rePasswordHint,
          prefixIcon: Icons.lock_outline,
          isPassword: true,
          suffixIcon: const Icon(Icons.visibility_off_outlined),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please confirm your password';
            }
            if (value != passwordController.text) {
              return "Passwords don't match";
            }
            return null;
          },
        ),
      ],
    );
  }
}
