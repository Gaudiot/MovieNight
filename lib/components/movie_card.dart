import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_night/routes/movie_detail/movie_detail.dart';
import 'package:movie_night/shared/app_colors.dart';
import 'package:movie_night/entities/movie.dart';
import 'package:movie_night/utils/time_formatter.dart';

class MovieCard extends StatelessWidget{
  final Movie movie;
  final List<IconButton> buttons;

  const MovieCard({super.key, required this.movie, this.buttons = const []});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetail(movie),));
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(5)
        ),
        margin: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: movie.posterPath,
              height: 130,
              placeholder: (context, url) => const SizedBox(width: 87, height: 130, child: Placeholder()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title),
                  Row(
                    children: [
                      const Icon(Icons.star),
                      Text(movie.rating.toStringAsFixed(2)),
                      const Icon(Icons.schedule),
                      Text(timeFormatter(movie.runtime)),
                    ],
                  )
                ],
              ),
            ),
            // Column(
            //   children: [
            //     for(String genre in movie.genres)
            //       _Genre(genre: genre)
            //   ],
            // ),
            ...buttons
          ],
        ),
      ),
    );
  }
}

class _Genre extends StatelessWidget{
  final String genre;

  const _Genre({required this.genre});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        border: Border.all(color: AppColors.black)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(genre),
      )
    );
  }
  
}