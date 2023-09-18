import 'package:flutter/material.dart';
import 'package:movie_night/shared/app_colors.dart';

class GenreItem extends StatelessWidget {
  final String genre;
  const GenreItem(this.genre, {super.key});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        color: AppColors.yellow
      ),
      padding: const EdgeInsets.all(10),
      child: Text(
        genre,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}