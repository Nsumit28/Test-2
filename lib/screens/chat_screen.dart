import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/typography.dart';

/// Placeholder Chat Screen
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VibelyColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Messages',
          style: VibelyTypography.label.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: VibelyColors.textPrimary,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 80,
              color: VibelyColors.textSecondary.withValues(alpha: 0.4),
            ),
            const SizedBox(height: 16),
            Text(
              'No messages yet',
              style: VibelyTypography.label.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: VibelyColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start swiping to match and chat!',
              style: VibelyTypography.label.copyWith(
                fontSize: 14,
                color: VibelyColors.textSecondary.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
