import 'package:flutter/material.dart';
import 'package:movie_night/shared/app_colors.dart';
import 'package:movie_night/shared/components/movie_card.dart';
import 'package:movie_night/entities/movie/movie.dart';
import 'package:movie_night/repositories/movies_db/movies_repository.dart';

class WatchedMovieCard extends StatelessWidget{
  final Movie movie;
  final MoviesRepository moviesRepository = MoviesRepository();
  final Function onAction;

  WatchedMovieCard({super.key, required this.movie, required this.onAction});

  Future<void> toggleFavorite() async{
    final String movieId = movie.getImdbId();
    await moviesRepository.toggleMovieFavorite(movieId);

    onAction();
  }

  Future<void> markAsUnwatched() async{
    final String movieId = movie.getImdbId();
    await moviesRepository.toggleMovieWatched(movieId);
    if(movie.favorite) await moviesRepository.toggleMovieFavorite(movieId);

    onAction();
  }
  
  @override
  Widget build(BuildContext context) {
    return MovieCard(
      movie: movie,
      buttons: [
        IconButton(
          onPressed: markAsUnwatched, 
          icon: const Icon(Icons.visibility_off)
        ),
        IconButton(
          onPressed: toggleFavorite, 
          icon: movie.favorite ? const Icon(Icons.favorite, color: AppColors.red) : const Icon(Icons.favorite_border)
        )
      ],
    );
  }
}