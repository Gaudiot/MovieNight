import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_night/shared/app_colors.dart';
import 'package:movie_night/entities/movie/movie.dart';
import 'package:movie_night/utils/time_formatter.dart';

class MovieCard extends StatelessWidget{
  final Movie movie;
  final List<IconButton> buttons;

  const MovieCard({super.key, required this.movie, this.buttons = const []});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/movie/${movie.imdbId}');
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
                  Text('${movie.title} (${movie.year})'),
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
            ...buttons
          ],
        ),
      ),
    );
  }
}