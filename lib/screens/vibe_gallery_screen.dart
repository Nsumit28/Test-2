import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../constants/colors.dart';
import '../constants/typography.dart';
import '../models/profile_model.dart';

/// Screen 2: Vibe Gallery
/// Hero image with 2-column grid below
class VibeGalleryScreen extends StatelessWidget {
  final ProfileModel profile;

  const VibeGalleryScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Label
          Text(
            profile.heroImage.label ?? 'Recent Adventure!',
            style: VibelyTypography.sectionHeader,
          ),
          const SizedBox(height: 12),

          // Hero Image
          _buildHeroImage(),
          const SizedBox(height: 16),

          // Secondary Grid (2-column)
          _buildSecondaryGrid(),
        ],
      ),
    );
  }

  Widget _buildHeroImage() {
    return Container(
      height: 420,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: VibelyColors.primary, width: 1.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.5),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Image
            CachedNetworkImage(
              imageUrl: profile.heroImage.imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: VibelyColors.cardBackground,
                child: const Center(
                  child: CircularProgressIndicator(color: VibelyColors.primary),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: VibelyColors.cardBackground,
                child: const Icon(Icons.image, size: 60),
              ),
            ),

            // Caption Overlay Gradient
            if (profile.heroImage.caption != null)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: VibelyColors.imageOverlayGradient,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(14.5),
                      bottomRight: Radius.circular(14.5),
                    ),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    '"${profile.heroImage.caption}"',
                    style: VibelyTypography.captionText,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecondaryGrid() {
    return Row(
      children: [
        for (int i = 0; i < profile.galleryImages.length && i < 2; i++) ...[
          if (i > 0) const SizedBox(width: 8),
          Expanded(child: _buildGridItem(profile.galleryImages[i])),
        ],
      ],
    );
  }

  Widget _buildGridItem(GalleryImage image) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 220,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Image
                CachedNetworkImage(
                  imageUrl: image.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: VibelyColors.cardBackground,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: VibelyColors.primary,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: VibelyColors.cardBackground,
                    child: const Icon(Icons.image, size: 40),
                  ),
                ),

                // Label Overlay
                if (image.label != null)
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 0, 0, 0.5),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        image.label!,
                        style: VibelyTypography.gridLabel,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (image.caption != null) ...[
          const SizedBox(height: 6),
          Text(image.caption!, style: VibelyTypography.gridCaption),
        ],
      ],
    );
  }
}
