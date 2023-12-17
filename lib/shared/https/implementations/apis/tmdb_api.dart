import 'package:dio/dio.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_night/entities/movie/movie.dart';

String authToken = dotenv.env["TMDB_API_KEY"] ?? "";

class TmdbApi{
  final _options = BaseOptions(
    baseUrl: "https://api.themoviedb.org/3",
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
    headers: {
      "authorization": "Bearer $authToken"
    }
  );
  
  late final Dio dio;

  TmdbApi(){
    dio = Dio(_options);
  }

  Future<Movie> _getMovieByTmdbId(String movieId) async {
    Response result = await dio.get('/movie/$movieId');
    var movieInfo = result.data;    

    String posterPath = movieInfo['poster_path'] != null ? 
      "https://image.tmdb.org/t/p/original${movieInfo['poster_path']}" 
      : "https://d994l96tlvogv.cloudfront.net/uploads/film/poster/poster-image-coming-soon-placeholder-no-logo-500-x-740_29376.png";

    List movieGenres = movieInfo["genres"];
    
    final int movieYear = (movieInfo["release_date"] as String).isNotEmpty ? DateTime.parse(movieInfo["release_date"]).year : 9999;
    final String imdbId = (movieInfo["imdb_id"] != null) ? movieInfo["imdb_id"] : "null";

    Movie movie = Movie(
      imdbId: imdbId,
      title: movieInfo["title"],
      year: movieYear,
      runtime: movieInfo["runtime"],
      genres: movieGenres.map<String>((genre) => genre["name"]).toList(),
      rating: movieInfo["vote_average"],
      synopsis: movieInfo["overview"],
      posterPath: posterPath
    );

    return movie;
  }

  Future<List<Movie>> getMovies({
    required String movieTitle,
    required int page
  }) async {
    Response result = await dio.get('/search/movie',
      queryParameters: {
        "query": movieTitle,
        "page": page
      }
    );
    
    List<dynamic> movieList = result.data['results'];
    movieList.sort((b, a) {
     if(a["popularity"] < b["popularity"]) return -1;
     if(b["popularity"] < a["popularity"]) return 1;
     return 0;
    });

    List<Movie> simplifiedMovieList = await Future.wait(movieList.map((movie) async {
      String movieId = movie["id"].toString();

      Movie completeMovie = await _getMovieByTmdbId(movieId);

      return completeMovie;
    }));

    simplifiedMovieList = simplifiedMovieList.where((movie) => movie.getImdbId() != "null").toList();

    return simplifiedMovieList;
  }

  Future<Movie?> getMovie({required String id}) async {
    try {
      Response response = await dio.get("/movie/$id");
      
      Movie movie = _dataToMovie(response.data);

      return movie;
    } catch (e) {
      return null;
    }
  }

  Movie _dataToMovie(dynamic rawData){
    String posterPath = rawData['poster_path'] != null ? 
      "https://image.tmdb.org/t/p/original${rawData['poster_path']}" 
      : "https://d994l96tlvogv.cloudfront.net/uploads/film/poster/poster-image-coming-soon-placeholder-no-logo-500-x-740_29376.png";

    Movie movie = Movie(
      imdbId: rawData["imdb_id"],
      title: rawData["title"],
      year: (rawData["release_date"] as String).isNotEmpty ? DateTime.parse(rawData["release_date"]).year : 9999,
      runtime: rawData["runtime"],
      genres: (rawData["genres"] as List<dynamic>).map<String>((rawGenre) => rawGenre["name"]).toList(),
      rating: rawData["vote_average"],
      synopsis: rawData["overview"],
      posterPath: posterPath
    );

    return movie;
  }
}