import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:movie_night/repositories/movies_db/models/i_movie_repository.dart';
import 'package:movie_night/shared/app_colors.dart';
import 'package:movie_night/shared/components/movie_card.dart';
import 'package:movie_night/entities/movie/movie.dart';
import 'package:movie_night/repositories/movies_db/movies_repository.dart';

class WatchedMovieCard extends StatelessWidget{
  final Movie movie;
  final IMovieRepository moviesRepository = MoviesRepository();
  final VoidCallback onUnwatchMovie;
  final VoidCallback onFavoriteMovie;

  WatchedMovieCard({super.key, required this.movie, required this.onUnwatchMovie, required this.onFavoriteMovie});

  Future<void> _toggleFavorite() async{
    final String movieId = movie.getImdbId();
    await moviesRepository.toggleMovieFavorite(movieId);

    onFavoriteMovie();
  }

  Future<void> _markAsUnwatched() async{
    final String movieId = movie.getImdbId();
    await moviesRepository.toggleMovieWatched(movieId);
    await moviesRepository.setMovieFavorite(movieId, false);

    onUnwatchMovie();
  }
  
  @override
  Widget build(BuildContext context) {
    return MovieCard(
      movie: movie,
      buttons: [
        IconButton(
          onPressed: _markAsUnwatched, 
          icon: const Icon(FontAwesomeIcons.eyeSlash, color: AppColors.black)
        ),
        IconButton(
          onPressed: _toggleFavorite, 
          icon: movie.favorite ? const Icon(FontAwesomeIcons.solidHeart, color: AppColors.red) : const Icon(FontAwesomeIcons.heart, color: AppColors.black)
        )
      ],
    );
  }
}