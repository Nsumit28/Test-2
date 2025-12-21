/// Model for personality stickers displayed on profile photos
class PersonalitySticker {
  final String emoji;
  final String text;

  const PersonalitySticker({required this.emoji, required this.text});
}

/// Model for gallery image with caption
class GalleryImage {
  final String imageUrl;
  final String? label;
  final String? caption;

  const GalleryImage({required this.imageUrl, this.label, this.caption});
}

/// Model for favorite movie
class FavoriteMovie {
  final String posterUrl;
  final String title;
  final String comment;

  const FavoriteMovie({
    required this.posterUrl,
    required this.title,
    required this.comment,
  });
}

/// Model for favorite song
class FavoriteSong {
  final String albumArtUrl;
  final String artist;
  final String songTitle;

  const FavoriteSong({
    required this.albumArtUrl,
    required this.artist,
    required this.songTitle,
  });
}

/// Model for favorite food
class FavoriteFood {
  final String iconUrl;
  final String name;

  const FavoriteFood({required this.iconUrl, required this.name});
}

/// Main profile model containing all user data
class ProfileModel {
  final String id;
  final String name;
  final int age;
  final double distanceKm;
  final String profilePhotoUrl;
  final String bio;
  final int vibeMatchPercent;
  final List<PersonalitySticker> stickers;
  final GalleryImage heroImage;
  final List<GalleryImage> galleryImages;
  final FavoriteMovie? favoriteMovie;
  final FavoriteSong? favoriteSong;
  final FavoriteFood? favoriteFood;

  const ProfileModel({
    required this.id,
    required this.name,
    required this.age,
    required this.distanceKm,
    required this.profilePhotoUrl,
    required this.bio,
    required this.vibeMatchPercent,
    required this.stickers,
    required this.heroImage,
    required this.galleryImages,
    this.favoriteMovie,
    this.favoriteSong,
    this.favoriteFood,
  });
}
