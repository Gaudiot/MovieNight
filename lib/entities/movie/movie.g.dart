// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      imdbId: json['imdbId'] as String,
      title: json['title'] as String,
      year: json['year'] as int,
      runtime: json['runtime'] as int,
      genres:
          (json['genres'] as List<dynamic>).map((e) => e as String).toList(),
      rating: (json['rating'] as num).toDouble(),
      synopsis: json['synopsis'] as String? ??
          "No available synopsis for this movie.",
      watched: json['watched'] as bool? ?? false,
      favorite: json['favorite'] as bool? ?? false,
      posterPath: json['posterPath'] as String? ??
          "https://www.altavod.com/assets/images/poster-placeholder.png",
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'imdbId': instance.imdbId,
      'title': instance.title,
      'year': instance.year,
      'synopsis': instance.synopsis,
      'runtime': instance.runtime,
      'genres': instance.genres,
      'rating': instance.rating,
      'posterPath': instance.posterPath,
      'watched': instance.watched,
      'favorite': instance.favorite,
    };
