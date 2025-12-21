import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../constants/colors.dart';
import '../constants/typography.dart';
import '../models/profile_model.dart';

/// Screen 3: Favorites
/// Movie, Song, and Food favorites sections
class FavoritesScreen extends StatelessWidget {
  final ProfileModel profile;

  const FavoritesScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Favorite Movie
          if (profile.favoriteMovie != null) ...[
            _buildMovieSection(profile.favoriteMovie!),
            const SizedBox(height: 24),
          ],

          // Favorite Song
          if (profile.favoriteSong != null) ...[
            _buildSongSection(profile.favoriteSong!),
            const SizedBox(height: 24),
          ],

          // Favorite Food
          if (profile.favoriteFood != null) ...[
            _buildFoodSection(profile.favoriteFood!),
          ],
        ],
      ),
    );
  }

  Widget _buildMovieSection(FavoriteMovie movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Text('🎬 Favorite Movie', style: VibelyTypography.sectionHeader),
        const SizedBox(height: 12),

        // Movie Row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: movie.posterUrl,
                width: 100,
                height: 150,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 100,
                  height: 150,
                  color: VibelyColors.cardBackground,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: VibelyColors.primary,
                      strokeWidth: 2,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 100,
                  height: 150,
                  color: VibelyColors.cardBackground,
                  child: const Icon(Icons.movie, size: 40),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Title and Comment
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: VibelyTypography.favoriteTitle),
                  const SizedBox(height: 8),
                  Text(
                    '"${movie.comment}"',
                    style: VibelyTypography.favoriteSubtitle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSongSection(FavoriteSong song) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Text('🎵 Favorite Song', style: VibelyTypography.sectionHeader),
        const SizedBox(height: 12),

        // Song Row
        Row(
          children: [
            // Album Art
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: song.albumArtUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 80,
                  height: 80,
                  color: VibelyColors.cardBackground,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: VibelyColors.primary,
                      strokeWidth: 2,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 80,
                  height: 80,
                  color: VibelyColors.cardBackground,
                  child: const Icon(Icons.music_note, size: 32),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Artist and Song Title
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(song.artist, style: VibelyTypography.favoriteTitle),
                  const SizedBox(height: 4),
                  Text(
                    song.songTitle,
                    style: VibelyTypography.favoriteSubtitle.copyWith(
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFoodSection(FavoriteFood food) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Text('🍜 Favorite Food', style: VibelyTypography.sectionHeader),
        const SizedBox(height: 12),

        // Food Row
        Row(
          children: [
            // Icon
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: food.iconUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 60,
                  height: 60,
                  color: VibelyColors.cardBackground,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: VibelyColors.primary,
                      strokeWidth: 2,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 60,
                  height: 60,
                  color: VibelyColors.cardBackground,
                  child: const Icon(Icons.restaurant, size: 28),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Name
            Expanded(
              child: Text(
                food.name,
                style: VibelyTypography.favoriteSubtitle.copyWith(
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
