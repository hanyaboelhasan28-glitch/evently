import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'profile_tab/widgets/logout_button.dart';
import 'profile_tab/widgets/profile_header.dart';
import 'profile_tab/widgets/profile_settings.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: Column(
        children: [
          ProfileHeader(
            name: user?.displayName ?? 'User Name',
            email: user?.email ?? 'user@example.com',
          ),
          const Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ProfileSettings(),
                  SizedBox(height: 20),
                  LogoutButton(),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
