import 'package:movie_night/entities/movie/movie.dart';
import 'package:movie_night/shared/https/implementations/apis/tmdb_api.dart';
import 'package:movie_night/shared/https/models/i_https.dart';

class Https implements IHttps {
  final TmdbApi tmdbApi = TmdbApi();
  
  @override
  Future<List<Movie>> getMoviesByTitle(String movieTitle, {int page = 1, int limit = 10}) async {
    final movies = await tmdbApi.getMovies(
      movieTitle: movieTitle,
      page: page
    );

    return movies;
  }
  
  @override
  Future<Movie?> getMovieById(String movieId) async {
    final Movie? movie = await tmdbApi.getMovie(id: movieId);
    
    return movie;
  }
}