import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(thickness: 1, color: AppColors.primary)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Or',
            style: TextStyle(color: AppColors.primary, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(child: Divider(thickness: 1, color: AppColors.primary)),
      ],
    );
  }
}
