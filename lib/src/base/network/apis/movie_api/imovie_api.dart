import "package:movie_night/src/base/network/network.dart";
import "package:movie_night/src/core/data/models/models.dart";
import "package:movie_night/src/core/exceptions/exceptions.dart";

abstract class IMovieApi {
  Future<Result<List<Movie>, NetworkException>> discoverMovies({
    int page = 1,
    int limit = 10,
  });
  Future<Result<List<Movie>, NetworkException>> getMovies({
    String? name,
    int page = 1,
    int limit = 10,
  });
  Future<Result<Movie, NetworkException>> getMovieDetails({
    required String movieId,
  });
  Future<Result<String, NetworkException>> getMovieTrailer({
    required String movieId,
  });
  Future<Result<List<Streaming>, NetworkException>> getMovieStreamings({
    required String movieId,
  });
  Future<Result<double, NetworkException>> getMovieRating({
    required String movieId,
  });
}
