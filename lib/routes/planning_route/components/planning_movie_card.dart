import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:movie_night/repositories/movies_db/models/i_movie_repository.dart';
import 'package:movie_night/shared/app_colors.dart';
import 'package:movie_night/shared/components/movie_card.dart';
import 'package:movie_night/entities/movie/movie.dart';
import 'package:movie_night/repositories/movies_db/movies_repository.dart';

class PlanningMovieCard extends StatelessWidget{
  final Movie movie;
  final IMovieRepository moviesRepository = MoviesRepository();
  final VoidCallback onWatchMovie;
  final VoidCallback onRemoveFromPlanning;

  PlanningMovieCard({super.key, required this.movie, required this.onWatchMovie, required this.onRemoveFromPlanning});

  Future<void> _onRemoveFromPlanningAction() async {
    final String movieId = movie.getImdbId();
    await moviesRepository.removeMovieFromPlanning(movieId);

    onRemoveFromPlanning();
  }

  Future<void> _onWatchMovieAction() async {
    final String movieId = movie.getImdbId();
    await moviesRepository.toggleMovieWatched(movieId);

    onWatchMovie();
  }
  
  @override
  Widget build(BuildContext context) {
    return MovieCard(
      movie: movie,
      buttons: [
        IconButton(
          onPressed: _onRemoveFromPlanningAction, 
          icon: const Icon(FontAwesomeIcons.trash),
          color: AppColors.black,
          disabledColor: AppColors.gray,
        ),
        IconButton(
          onPressed: _onWatchMovieAction, 
          icon: const Icon(FontAwesomeIcons.eye),
          color: AppColors.black,
          disabledColor: AppColors.gray,
        )
      ],
    );
  }
}