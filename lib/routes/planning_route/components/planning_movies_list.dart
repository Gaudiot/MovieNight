import 'package:flutter/material.dart';

import 'package:movie_night/entities/movie/movie.dart';
import 'package:movie_night/repositories/movies_db/models/i_movie_repository.dart';
import 'package:movie_night/repositories/movies_db/movies_repository.dart';
import 'package:movie_night/routes/planning_route/components/planning_movie_card.dart';

class PlanningMoviesList extends StatefulWidget {
  final String movieTitle;
  final String movieGenre;
  const PlanningMoviesList({super.key, required this.movieTitle, required this.movieGenre});

  @override
  State<PlanningMoviesList> createState() => _PlanningMoviesListState();
}

class _PlanningMoviesListState extends State<PlanningMoviesList> {
  final IMovieRepository moviesRepository = MoviesRepository();

  Future<List<Movie>>? movies;

  @override
  void initState() {
    super.initState();
    movies = moviesRepository.getMovies(
      movieTitle: widget.movieTitle,
      movieGenre: widget.movieGenre,
      watched: false
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: movies,
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator());
        }
        if(!snapshot.hasData){
          return const _NoMoviesFound();
        }
        if(snapshot.hasError){
          return const _ErrorFetchingData();
        }

        List<Movie> movies = snapshot.requireData;
        movies.sort();

        if(movies.isEmpty){
          return const _NoMoviesFound();
        }

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index){
            final Movie movie = movies[index];
            return PlanningMovieCard(
              movie: movie, 
              onAction: (){setState(() {});}
            ); 
          }
        );
      }
    );
  }
}

class _NoMoviesFound extends StatelessWidget {
  const _NoMoviesFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("No movies found with the given name and/or genre.")
    );
  }
}

class _ErrorFetchingData extends StatelessWidget {
  const _ErrorFetchingData({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("An error occured while fetching the data");
  }
}