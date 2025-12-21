import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../constants/colors.dart';
import '../constants/typography.dart';
import '../models/profile_model.dart';
import '../widgets/personality_sticker.dart';
import '../widgets/vibe_match_badge.dart';

/// Screen 1: Quick View
/// Main profile photo with stickers, vibe badge, name, and bio
class QuickViewScreen extends StatelessWidget {
  final ProfileModel profile;

  const QuickViewScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final photoHeight = screenHeight * 0.55;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Profile Photo Container with Stickers and Vibe Badge
        Container(
          height: photoHeight,
          margin: const EdgeInsets.all(16),
          child: Stack(
            children: [
              // Photo with orange border
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: VibelyColors.secondary, width: 2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: CachedNetworkImage(
                    imageUrl: profile.profilePhotoUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: VibelyColors.cardBackground,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: VibelyColors.primary,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: VibelyColors.cardBackground,
                      child: const Icon(
                        Icons.person,
                        size: 80,
                        color: VibelyColors.textSecondary,
                      ),
                    ),
                  ),
                ),
              ),

              // Personality Stickers - top left
              Positioned(
                top: 12,
                left: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < profile.stickers.length; i++) ...[
                      PersonalityStickerWidget(
                        emoji: profile.stickers[i].emoji,
                        text: profile.stickers[i].text,
                        borderColor: i % 2 == 0
                            ? VibelyColors.secondary
                            : VibelyColors.primary,
                      ),
                      if (i < profile.stickers.length - 1)
                        const SizedBox(height: 12),
                    ],
                  ],
                ),
              ),

              // Vibe Match Badge - bottom right
              Positioned(
                bottom: 12,
                right: 12,
                child: VibeMatchBadge(percentage: profile.vibeMatchPercent),
              ),
            ],
          ),
        ),

        // Info Section
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Name and Distance Row
                Row(
                  children: [
                    Text(
                      '${profile.name}, ${profile.age}',
                      style: VibelyTypography.nameText,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '📍 ${profile.distanceKm} km',
                      style: VibelyTypography.distanceText,
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Bio
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    '✨ ${profile.bio}',
                    style: VibelyTypography.bioText,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
