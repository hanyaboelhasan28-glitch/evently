import 'package:flutter/material.dart';
import '../../../../core/assets/app_images.dart';
import '../../../../core/assets/app_strings.dart';
import '../../../../core/theme/app_colors.dart';

class GoogleLoginButton extends StatelessWidget {
  final VoidCallback onTap;

  const GoogleLoginButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 56),
        side: const BorderSide(color: AppColors.primary, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.googleIcon,
            height: 24,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.g_mobiledata, size: 30, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          const Text(
            AppStrings.loginWithGoogle,
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
