import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppStyles {
  static const TextStyle titlePrimary = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const TextStyle titleBlack = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static const TextStyle titleWhite = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static const TextStyle bodyWhite = TextStyle(
    fontSize: 14,
    color: AppColors.white,
  );

  static const TextStyle bodyBlack = TextStyle(
    fontSize: 16,
    color: AppColors.black,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle bodyGrey = TextStyle(
    fontSize: 16,
    color: AppColors.grey,
  );

  static const TextStyle buttonWhite = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );
  
  static const TextStyle linkPrimary = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
    decoration: TextDecoration.underline,
    fontStyle: FontStyle.italic,
  );
}
