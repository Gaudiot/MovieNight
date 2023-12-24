import 'package:movie_night/entities/movie/movie.dart';

abstract class IMovieRepository{
  Future<List<Movie>> getAllMovies();
  Future<List<Movie>> getMovies({String? movieTitle, String? movieGenre, bool watched = false});
  Future<Movie?> getMovieById(String movieId);
  Future<List<Movie>> getMoviesByGenre(String genre);
  Future<void> toggleMovieWatched(String movieId);
  Future<void> toggleMovieFavorite(String movieId);
  Future<void> addMovieToPlanning(Movie movie);
  Future<void> removeMovieFromPlanning(String movieId);
  Future<void> setMovieFavorite(String movieId, bool value);
  Future<void> clearMovies();
}