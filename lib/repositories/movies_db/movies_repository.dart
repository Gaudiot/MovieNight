import 'dart:convert';

import 'package:movie_night/entities/movie.dart';
import 'package:movie_night/repositories/local_storage.dart';

class MoviesRepository {
  static Future<List<Movie>> getMovies() async{
    List<String> encodedMovies = await LocalStorage.getStringList('movies');

    List<Movie> movies = encodedMovies.map<Movie>((movie) => Movie.fromMap(jsonDecode(movie))).toList();

    return movies;
  }

  static Future<List<Movie>> findMoviesWhere({String? title, String? genrer, bool? watched}) async{
    List<Movie> movies = await getMovies();
    if(title != null && title.isNotEmpty) movies = movies.where((movie) => movie.title.toLowerCase().contains(title.toLowerCase())).toList();
    if(genrer != null && genrer != "All") movies = movies.where((movie) => movie.genres.contains(genrer)).toList();
    if(watched != null) movies = movies.where((movie) => movie.watched == watched).toList();

    return movies;
  }

  static Future<void> toggleWatchMovie(String movieId) async{
    List<Movie> movies = await getMovies();
    int movieIndex = movies.indexWhere((movie) => movie.id == movieId);
    movies[movieIndex].watched = !movies[movieIndex].watched;

    await saveMovies(movies);
  }

  static Future<void> deleteById(String movieId) async{
    List<Movie> movies = await getMovies();
    movies.removeWhere((movie) => movie.id == movieId);

    await saveMovies(movies);
  }

  static Future<void> toggleFavoriteMovie(String movieId) async{
    List<Movie> movies = await getMovies();
    int movieIndex = movies.indexWhere((movie) => movie.id == movieId);
    movies[movieIndex].favorite = !movies[movieIndex].favorite;

    await saveMovies(movies);
  }

  static Future<void> addMovieToPlanning(Movie movie) async{
    List<Movie> movies = await getMovies();
    movies.add(movie);

    await saveMovies(movies);
  }

  static Future<void> saveMovies(List<Movie> movies) async{
    List<String> newEncodedMovies = movies.map<String>((movie) => jsonEncode(movie.toMap())).toList();
    await LocalStorage.setStringList("movies", newEncodedMovies);
  }

  static Future<void> dropMovies() async{
    await LocalStorage.setStringList("movies", []);
  }
}