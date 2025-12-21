import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/typography.dart';

/// Personality sticker badge widget displayed on profile photos
/// Matches wireframe specs: white bg, orange border, rounded corners with shadow
class PersonalityStickerWidget extends StatelessWidget {
  final String emoji;
  final String text;
  final Color? borderColor;

  const PersonalityStickerWidget({
    super.key,
    required this.emoji,
    required this.text,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.95),
        border: Border.all(
          color: borderColor ?? VibelyColors.secondary,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 4),
          Text(text, style: VibelyTypography.stickerText),
        ],
      ),
    );
  }
}
