import 'package:uuid/uuid.dart';

const Uuid uuid = Uuid();

class Movie implements Comparable<Movie>{
  late String id;
  final String title;
  final String synopsis;
  final int runtime;
  final List<String> genres;
  final double rating;
  late String posterPath;

  bool watched = false;
  bool favorite = false;

  Movie({
    required this.title,
    required this.runtime,
    required this.genres,
    required this.rating,
    this.synopsis = "No available synopsis for this movie.",
    this.watched = false,
    this.favorite = false,
    this.posterPath = "https://www.altavod.com/assets/images/poster-placeholder.png"
    // this.posterPath = "https://d994l96tlvogv.cloudfront.net/uploads/film/poster/poster-image-coming-soon-placeholder-no-logo-500-x-740_29376.png"
  }){
    id = uuid.v4();
  }

  @override
  int compareTo(Movie other){
    if(rating < other.rating) return 1;
    if(rating == other.rating) return 0;
    return -1;
  }

  void _setMovieId(String newId){
    id = newId;
  }

  factory Movie.fromMap(Map map){
    Movie movie = Movie(
      title: map['title'], 
      runtime: map['runtime'], 
      genres: List<String>.from(map['genres']), 
      rating: map['rating'],
      synopsis: map['synopsis'],
      watched: map['watched'],
      favorite: map['favorite'],
      posterPath: map['posterPath']
    );
    movie._setMovieId(map['id']);

    return movie;
  }

  Map toMap(){
    return {
      'id': id,
      'title': title,
      'runtime': runtime,
      'genres': genres,
      'rating': rating,
      'synopsis': synopsis,
      'watched': watched,
      'favorite': favorite,
      'posterPath': posterPath
    };
  }
}