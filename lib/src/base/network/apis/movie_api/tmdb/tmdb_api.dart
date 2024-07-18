import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:movie_night/src/base/network/apis/movie_api/movie_api.dart";
import "package:movie_night/src/base/network/network.dart";
import "package:movie_night/src/core/data/models/models.dart";
import "package:movie_night/src/core/exceptions/network_exception.dart";

part "package:movie_night/src/base/network/apis/movie_api/tmdb/tmdb_responses.dart";

class TmdbApi implements IMovieApi {
  final INetwork network = getNetworkProvider(
    baseUrl: "https://api.themoviedb.org/3",
    bearerToken: dotenv.env["TMDB_API_KEY"] ?? "",
  );

  @override
  Future<Result<List<Movie>, NetworkException>> discoverMovies({
    int page = 1,
    int limit = 10,
  }) async {
    final result = await network.get(
      url: "/discover/movie",
      queryParameters: {
        "page": page.toString(),
        "limit": limit.toString(),
      },
    );

    if (result.hasError) {
      return error(result.error);
    }

    final List<String> moviesIds = _getMoviesIdsFromJson(result.value);
    final moviesResult = await Future.wait(
      List.generate(
        moviesIds.length,
        (index) {
          final movieId = moviesIds[index];

          return getMovieDetails(movieId: movieId);
        },
      ),
    );
    final movies = moviesResult.where((result) => (result.isOk)).map((result) {
      return result.value!;
    }).toList();

    return ok(movies);
  }

  @override
  Future<Result<List<Movie>, NetworkException>> getMovies({
    String? name,
    int page = 1,
    int limit = 10,
  }) async {
    final result = await network.get(
      url: "/search/movie/",
      queryParameters: {
        "query": name ?? "",
        "page": page.toString(),
        "limit": limit.toString(),
      },
    );

    if (result.hasError) {
      return error(result.error);
    }

    final List<String> moviesIds = _getMoviesIdsFromJson(result.value);
    final moviesResult = await Future.wait(
      List.generate(
        moviesIds.length,
        (index) {
          final movieId = moviesIds[index];

          return getMovieDetails(movieId: movieId);
        },
      ),
    );
    final movies = moviesResult.where((result) => result.isOk).map((result) {
      return result.value!;
    }).toList();

    return ok(movies);
  }

  @override
  Future<Result<Movie, NetworkException>> getMovieDetails({
    required String movieId,
  }) async {
    final result = await network.get(
      url: "/movie/$movieId",
    );

    if (result.hasError) {
      return error(result.error);
    }

    final movie = _getMovieDetailsFromJson(result.value);

    return ok(movie);
  }

  @override
  Future<Result<List<Streaming>, NetworkException>> getMovieStreamings({
    required String movieId,
  }) async {
    final result = await network.get(
      url: "/movie/$movieId/watch/providers",
    );

    if (result.hasError) {
      return error(result.error);
    }

    final streamings = _getMovieStreamingsFromJson(result.value);

    return ok(streamings);
  }

  @override
  Future<Result<String, NetworkException>> getMovieTrailer({
    required String movieId,
  }) async {
    final result = await network.get(
      url: "/movie/$movieId/videos",
    );

    if (result.hasError) {
      return error(result.error);
    }

    final trailer = _getMovieTrailerFromJson(result.value);

    return ok(trailer);
  }

  @override
  Future<Result<double, NetworkException>> getMovieRating({
    required String movieId,
  }) async {
    final result = await getMovieDetails(movieId: movieId);

    if (result.hasError) {
      return error(result.error);
    }

    return ok(result.value!.rating);
  }
}
