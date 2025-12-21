import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/typography.dart';

/// Vibe match badge widget with gradient background
/// Displays percentage match with lightning bolt emoji
class VibeMatchBadge extends StatelessWidget {
  final int percentage;

  const VibeMatchBadge({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: VibelyColors.primaryGradient,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text('$percentage% Vibe ⚡', style: VibelyTypography.vibeBadgeText),
    );
  }
}
