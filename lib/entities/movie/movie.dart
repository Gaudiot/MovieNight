import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie implements Comparable<Movie>{
  final String imdbId;
  final String title;
  final int year;
  final String synopsis;
  final int runtime;
  final List<String> genres;
  final double rating;
  final String posterPath;

  bool watched = false;
  bool favorite = false;

  Movie({
    required this.imdbId,
    required this.title,
    required this.year,
    required this.runtime,
    required this.genres,
    required this.rating,
    this.synopsis = "No available synopsis for this movie.",
    this.watched = false,
    this.favorite = false,
    this.posterPath = "https://www.altavod.com/assets/images/poster-placeholder.png"
  });

  String getImdbId(){
    return imdbId;
  }

  bool titleContains(String movieTitle){
    movieTitle = movieTitle.toLowerCase().trim();

    return title.toLowerCase().contains(movieTitle);
  }

  @override
  int compareTo(Movie other){
    if(rating < other.rating) return 1;
    if(rating == other.rating) return 0;
    return -1;
  }
  
  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);

  factory Movie.fromString(String movieRaw){
    final jsonMovie = jsonDecode(movieRaw);
    return Movie.fromJson(jsonMovie);
  }

  @override
  String toString(){
    final encodedMovie = jsonEncode(this);
    return encodedMovie;
  }
}