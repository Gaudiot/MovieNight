import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_night/components/movie_card.dart';
import 'package:movie_night/entities/movie.dart';
import 'package:movie_night/repositories/movies_db/movies_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CatalogMovieCard extends StatefulWidget {
  final Movie movie;

  const CatalogMovieCard({super.key, required this.movie});

  @override
  State<CatalogMovieCard> createState() => _CatalogMovieCardState();
}

class _CatalogMovieCardState extends State<CatalogMovieCard> {
  MoviesRepository moviesRepository = MoviesRepository();

  Future<void> addMovieToPlanning() async{
    // moviesRepository.addMovieToPlanning(widget.movie);


    SharedPreferences _prefs = await SharedPreferences.getInstance();

    List<String> encodedMovies = _prefs.getStringList("@MovieNight/movies") ?? [];
    encodedMovies.add(jsonEncode(widget.movie.toMap()));
    await _prefs.setStringList("@MovieNight/movies", encodedMovies);
    
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Movie added to list"),
      duration: Duration(seconds: 3),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MovieCard(
      movie: widget.movie,
      buttons: [
        IconButton(
          onPressed: addMovieToPlanning,
          icon: const Icon(Icons.add_circle_outline)
        )
      ],
    );
  }
}