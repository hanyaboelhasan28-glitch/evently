import 'package:flutter/material.dart';
import '../../../../../../core/assets/app_images.dart';
import '../../../../../../core/theme/app_colors.dart';
import 'category_item.dart';

class HomeHeader extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategoryChanged;

  const HomeHeader({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 16),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome Back \u2728',
                      style: TextStyle(color: Colors.white, fontSize: 14)),
                  Text('John Safwat',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.wb_sunny_outlined, color: Colors.white),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('EN',
                        style: TextStyle(
                            color: AppColors.primary, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CategoryItem(
                  title: 'All',
                  iconPath: AppImages.elementIcon,
                  isSelected: selectedCategory == 'All',
                  onTap: () => onCategoryChanged('All'),
                ),
                CategoryItem(
                  title: 'Sport',
                  iconPath: AppImages.sport,
                  isSelected: selectedCategory == 'Sport',
                  onTap: () => onCategoryChanged('Sport'),
                ),
                CategoryItem(
                  title: 'Birthday',
                  iconPath: AppImages.birthday,
                  isSelected: selectedCategory == 'Birthday',
                  onTap: () => onCategoryChanged('Birthday'),
                ),
                CategoryItem(
                  title: 'Meeting',
                  iconPath: AppImages.meeting,
                  isSelected: selectedCategory == 'Meeting',
                  onTap: () => onCategoryChanged('Meeting'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
