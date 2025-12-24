import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/typography.dart';

/// Placeholder Profile Screen
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VibelyColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'My Profile',
          style: VibelyTypography.label.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: VibelyColors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              debugPrint('Settings tapped');
            },
            icon: const Icon(
              Icons.settings_outlined,
              color: VibelyColors.textPrimary,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: VibelyColors.cardBackground,
                shape: BoxShape.circle,
                border: Border.all(color: VibelyColors.secondary, width: 2),
              ),
              child: const Icon(
                Icons.person,
                size: 50,
                color: VibelyColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Your Profile',
              style: VibelyTypography.label.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: VibelyColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Complete your profile to get more matches',
              style: VibelyTypography.label.copyWith(
                fontSize: 14,
                color: VibelyColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                gradient: VibelyColors.primaryGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Edit Profile',
                style: VibelyTypography.button.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
