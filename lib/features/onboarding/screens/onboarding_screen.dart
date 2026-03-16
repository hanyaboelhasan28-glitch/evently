import 'package:flutter/material.dart';
import '../../../core/assets/app_images.dart';
import '../../../core/assets/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../auth/screens/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = 'onboarding';
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingContent> _contents = [
    OnboardingContent(
      title: AppStrings.onboardingTitle1,
      description: AppStrings.onboardingDesc1,
      image: AppImages.illustration1,
    ),
    OnboardingContent(
      title: AppStrings.onboardingTitle2,
      description: AppStrings.onboardingDesc2,
      image: AppImages.illustration2,
    ),
    OnboardingContent(
      title: AppStrings.onboardingTitle3,
      description: AppStrings.onboardingDesc3,
      image: AppImages.illustration3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: _currentIndex > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.primary),
                onPressed: () => _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
              )
            : null,
        centerTitle: true,
        title: Image.asset(AppImages.logo, height: 40, errorBuilder: (context, error, stackTrace) => const Text('EVENTLY', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 20))),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushReplacementNamed(context, LoginScreen.routeName),
            child: const Text(AppStrings.skip, style: TextStyle(color: AppColors.primary, fontSize: 16)),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            flex: 2,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: _contents.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                          _contents[index].image,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(Icons.image, size: 100, color: AppColors.primary),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Indicators exactly below image as in design
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _contents.length,
                          (idx) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: 8,
                            width: _currentIndex == idx ? 24 : 8,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _contents[index].title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _contents[index].description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.black,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_currentIndex == _contents.length - 1) {
                    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                  } else {
                    _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  _currentIndex == _contents.length - 1 ? AppStrings.getStarted : AppStrings.next,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingContent {
  final String title;
  final String description;
  final String image;

  OnboardingContent({
    required this.title,
    required this.description,
    required this.image,
  });
}
