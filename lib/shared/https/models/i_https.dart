import 'package:movie_night/entities/movie/movie.dart';

abstract class IHttps{
  /// Look in the internet for movies with the specified title
  Future<List<Movie>> getMoviesByTitle(String movieTitle, {int page = 1, int limit = 10});
}