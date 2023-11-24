import 'package:flutter/material.dart';
import 'package:movie_night/components/movie_card.dart';
import 'package:movie_night/entities/movie.dart';
import 'package:movie_night/repositories/movies_db/movies_repository.dart';

class CatalogMovieCard extends StatefulWidget {
  final Movie movie;

  const CatalogMovieCard({super.key, required this.movie});

  @override
  State<CatalogMovieCard> createState() => _CatalogMovieCardState();
}

class _CatalogMovieCardState extends State<CatalogMovieCard> {
  Future<void> addMovieToPlanning(Movie movie) async{
    MoviesRepository.addMovieToPlanning(movie);
    
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Movie added to list"),
      duration: Duration(seconds: 3),
    ));
  }

  Future<bool> checkMovieOnList(String movieId) async{
    Movie? movie = await MoviesRepository.findMovieById(movieId);

    return (movie != null);
  }

  @override
  Widget build(BuildContext context) {
    Movie movie = widget.movie;

    return FutureBuilder(
      future: checkMovieOnList(movie.getImdbId()),
      builder: (context, snapshot) {
        if(!snapshot.hasData || snapshot.hasError) return Placeholder();

        final bool isMovieOnList = snapshot.requireData;

        return MovieCard(
          movie: movie,
          buttons: [
            IconButton(
              onPressed: (isMovieOnList) ? null : () => {addMovieToPlanning(movie)},
              icon: const Icon(Icons.add_circle_outline)
            )
          ],
        );
      },
    );
  }
}