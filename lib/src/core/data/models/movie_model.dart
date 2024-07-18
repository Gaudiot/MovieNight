class Movie {
  final String id;
  final String title;
  final String synopsis;
  final double rating;
  final DateTime releaseDate;
  final int runtime;
  final bool favorite;
  final List<String> genres;
  final String? poster;
  final String? backdropPoster;

  final DateTime? updatedAt;
  final DateTime? watchedAt;

  Movie({
    required this.id,
    required this.title,
    required this.synopsis,
    required this.rating,
    required this.releaseDate,
    required this.runtime,
    required this.genres,
    this.updatedAt,
    this.poster,
    this.backdropPoster,
    this.favorite = false,
    this.watchedAt,
  });
}
