import 'package:flutter/material.dart';
import 'package:movie_night/shared/components/movie_card.dart';
import 'package:movie_night/entities/movie/movie.dart';
import 'package:movie_night/repositories/movies_db/movies_repository.dart';

class PlanningMovieCard extends StatelessWidget{
  final Movie movie;
  final MoviesRepository moviesRepository = MoviesRepository();
  final Function onAction;

  PlanningMovieCard({super.key, required this.movie, required this.onAction});

  Future<void> removeMovie() async{
    final String movieId = movie.getImdbId();
    await moviesRepository.removeMovieFromPlanning(movieId);

    onAction();
  }

  Future<void> markAsWatched() async{
    final String movieId = movie.getImdbId();
    await moviesRepository.toggleMovieWatched(movieId);

    onAction();
  }
  
  @override
  Widget build(BuildContext context) {
    return MovieCard(
      movie: movie,
      buttons: [
        IconButton(
          onPressed: removeMovie, 
          icon: const Icon(Icons.delete)
        ),
        IconButton(
          onPressed: markAsWatched, 
          icon: const Icon(Icons.visibility)
        )
      ],
    );
  }
}