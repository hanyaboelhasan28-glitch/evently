import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_colors.dart';

class FavoriteSearchBar extends StatelessWidget {
  final Function(String) onChanged;

  const FavoriteSearchBar({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Search for Event',
          hintStyle: const TextStyle(color: AppColors.primary),
          prefixIcon: const Icon(Icons.search, color: AppColors.primary),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
        ),
      ),
    );
  }
}
