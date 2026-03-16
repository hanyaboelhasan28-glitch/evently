import 'package:flutter/material.dart';
import '../../../../core/assets/app_images.dart';
import '../../../../core/theme/app_colors.dart';

class LoginLogo extends StatelessWidget {
  const LoginLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImages.logo,
      height: 50,
      errorBuilder: (context, error, stackTrace) => const Text(
        'EVENTLY',
        style: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          fontSize: 30,
          letterSpacing: 2,
        ),
      ),
    );
  }
}
