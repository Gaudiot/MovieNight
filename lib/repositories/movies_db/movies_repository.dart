import 'package:movie_night/entities/movie/movie.dart';
import 'package:movie_night/repositories/local_storage.dart';
import 'package:movie_night/repositories/movies_db/models/i_movie_repository.dart';
import 'package:movie_night/repositories/movies_db/movies_mock_db.dart';

class MoviesRepository implements IMovieRepository{
  @override
  Future<List<Movie>> getAllMovies() async {
    final List<String> moviesRaw = await LocalStorage.getStringList("movies");

    final List<Movie> movies = moviesRaw.map<Movie>((movie) => Movie.fromString(movie)).toList();
    // final List<Movie> movies = allMovies;

    return movies;
  }

  @override
  Future<List<Movie>> getMovies({String? movieTitle, String? movieGenre, bool watched = false}) async {
    List<Movie> movies = await getAllMovies();
    
    movies = movies.where((movie){
      if(movie.watched != watched) return false;
      if(movieGenre != null && movieGenre != "All" && movieGenre.isNotEmpty && movie.genres.contains(movieGenre) == false) return false;
      if(movieTitle != null && movieTitle.isNotEmpty && movie.titleContains(movieTitle) == false) return false;

      return true;
    }).toList();

    return movies;
  }

  @override
  Future<Movie?> getMovieById(String movieId) async{
    final List<Movie> movies = await getAllMovies();
    final movieIndex = movies.indexWhere((movie) => movie.imdbId == movieId);

    if(movieIndex == -1) return null;

    return movies[movieIndex];
  }

  @override
  Future<List<Movie>> getMoviesByGenre(String genre) async {
    List<Movie> movies = await getAllMovies();
    movies = movies.where((movie) => movie.genres.contains(genre)).toList();

    return movies;
  }

  @override
  Future<void> removeMovieFromPlanning(String movieId) async {
    final List<Movie> movies = await getAllMovies();
    final movieIndex = movies.indexWhere((movie) => movie.imdbId == movieId);

    movies.removeAt(movieIndex);

    final rawMovies = movies.map((movie) => movie.toString()).toList();
    await LocalStorage.setStringList("movies", rawMovies);
  }

  @override
  Future<void> addMovieToPlanning(Movie movie) async {
    final List<Movie> movies = await getAllMovies();
    movies.add(movie);

    final rawMovies = movies.map((movie) => movie.toString()).toList();
    await LocalStorage.setStringList("movies", rawMovies);
  }

  @override
  Future<void> clearMovies() async {
    await LocalStorage.clearKey("movies");
  }

  @override
  Future<void> toggleMovieFavorite(String movieId) async {
    final List<Movie> movies = await getAllMovies();
    final movieIndex = movies.indexWhere((movie) => movie.imdbId == movieId);
    final movie = movies[movieIndex];

    movie.favorite = !movie.favorite;
    movies[movieIndex] = movie;

    final rawMovies = movies.map((movie) => movie.toString()).toList();
    await LocalStorage.setStringList("movies", rawMovies);
  }

  @override
  Future<void> toggleMovieWatched(String movieId) async {
    final List<Movie> movies = await getAllMovies();
    final movieIndex = movies.indexWhere((movie) => movie.imdbId == movieId);
    final movie = movies[movieIndex];

    movie.watched = !movie.watched;
    movies[movieIndex] = movie;

    final rawMovies = movies.map((movie) => movie.toString()).toList();
    await LocalStorage.setStringList("movies", rawMovies);
  }

  @override
  Future<void> setMovieFavorite(String movieId, bool value) async {
    final List<Movie> movies = await getAllMovies();
    final movieIndex = movies.indexWhere((movie) => movie.imdbId == movieId);
    final movie = movies[movieIndex];

    movie.favorite = value;
    movies[movieIndex] = movie;

    final rawMovies = movies.map((movie) => movie.toString()).toList();
    await LocalStorage.setStringList("movies", rawMovies);
  }
}