import 'package:flutter/material.dart';
import 'package:movie_night/components/movie_card.dart';
import 'package:movie_night/entities/movie.dart';

Movie twixMovie = Movie(
  imdbId: "fofolinda",
  title: "Twix: Uma fofolinda na perfeição",
  year: 2022,
  runtime: 722,
  rating: 10,
  genres: ["Romance", "Action"],
  posterPath: "https://i.pinimg.com/originals/12/b3/ae/12b3ae2dc1cbd63db2e22b67af8cc9ec.jpg" 
);

class HiddenMovie extends StatelessWidget{
  const HiddenMovie({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MovieCard(movie: twixMovie);
  }
}