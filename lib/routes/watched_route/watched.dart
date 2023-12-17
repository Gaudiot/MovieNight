import 'package:flutter/material.dart';

import 'package:movie_night/routes/watched_route/components/watched_movies_list.dart';
import 'package:movie_night/shared/app_colors.dart';
import 'package:movie_night/repositories/movies_db/movies_repository.dart';

class Watched extends StatefulWidget{

  const Watched({super.key});

  @override
  State<Watched> createState() => _WatchedState();
}

class _WatchedState extends State<Watched> {
  final MoviesRepository moviesRepository = MoviesRepository();

  String titleToQuery = "";

  void updateQueryTitle(String movieName){
    setState(() {
      titleToQuery = movieName.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: AppColors.black
            ),
            child: TextField(
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.search, color: AppColors.yellow),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: "Search movie...",
                hintStyle: TextStyle(color: AppColors.gray)
              ),
              style: const TextStyle(color: AppColors.yellow),
              cursorColor: AppColors.yellow,
              
              onChanged: (movieName) => updateQueryTitle(movieName),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "Watched",
            style: TextStyle(color: AppColors.yellow, fontSize: 32),
          ),
        ),
        Expanded(
          child: WatchedMoviesList(key: UniqueKey(), movieTitle: titleToQuery)
        )
      ],
    );
  }
}