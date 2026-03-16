import 'package:flutter/material.dart';
import '../../../core/assets/app_images.dart';
import '../../../core/theme/app_colors.dart';
import 'tabs/favorite_tab.dart';
import 'tabs/home_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final List<Widget> _tabs = [
    const HomeTab(),
    const FavoriteTab(),
    const Center(child: Text('Profile Content')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AppImages.homeIcon)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AppImages.favoriteIcon)),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AppImages.profileIcon)),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        shape: const CircleBorder(side: BorderSide(color: AppColors.white, width: 4)),
        child: const Icon(Icons.add, color: AppColors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
