import 'package:flutter/material.dart';

import 'package:movie_night/routes/movie_detail/components/genre_item.dart';

class DisplayGenres extends StatelessWidget {
  final List<String> movieGenres;
  const DisplayGenres(this.movieGenres, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Wrap(
        spacing: 5,
        runSpacing: 5,
        children: [
          for(String genre in movieGenres)
            GenreItem(genre)
        ]
      ),
    );
  }
}