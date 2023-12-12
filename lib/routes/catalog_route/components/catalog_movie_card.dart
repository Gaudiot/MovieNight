import 'package:flutter/material.dart';
import 'package:movie_night/shared/components/movie_card.dart';
import 'package:movie_night/entities/movie/movie.dart';
import 'package:movie_night/repositories/movies_db/movies_repository.dart';

class CatalogMovieCard extends StatefulWidget {
  final Movie movie;

  const CatalogMovieCard({super.key, required this.movie});

  @override
  State<CatalogMovieCard> createState() => _CatalogMovieCardState();
}

class _CatalogMovieCardState extends State<CatalogMovieCard> {
  final moviesRepository = MoviesRepository();

  Future<bool>? _isMovieInList;

  @override
  void initState(){
    super.initState();
    _isMovieInList = checkMovieInList(widget.movie.imdbId);
  }

  Future<void> addMovieToPlanning(Movie movie) async{
    moviesRepository.addMovieToPlanning(movie);
    
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Movie added to list"),
      duration: Duration(seconds: 3),
    ));
  }

  Future<bool> checkMovieInList(String movieId) async{
    Movie? movie = await moviesRepository.getMovieById(movieId);

    return (movie != null);
  }

  @override
  Widget build(BuildContext context) {
    Movie movie = widget.movie;

    return FutureBuilder(
      future: _isMovieInList,
      builder: (context, snapshot) {
        if(!snapshot.hasData || snapshot.hasError) return const Placeholder();

        final bool isMovieInList = snapshot.requireData;

        return MovieCard(
          movie: movie,
          buttons: [
            IconButton(
              onPressed: (isMovieInList) ? null : () => {addMovieToPlanning(movie)},
              icon: const Icon(Icons.add_circle_outline)
            )
          ],
        );
      },
    );
  }
}