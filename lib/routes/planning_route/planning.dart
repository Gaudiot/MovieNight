import 'package:flutter/material.dart';

import 'package:movie_night/shared/app_colors.dart';
import 'package:movie_night/routes/planning_route/components/genre_filter.dart';
import 'package:movie_night/routes/planning_route/components/planning_movies_list.dart';

class Planning extends StatefulWidget{

  const Planning({super.key});

  @override
  State<Planning> createState() => _PlanningState();
}

class _PlanningState extends State<Planning> {
  String titleToQuery = "";
  String? genreToQuery = "All";

  void updateQueryGenre(String? genre){
    setState(() {
      genreToQuery = genre;
    });
  }

  void updateQueryTitle(String movieName){
    setState(() {
      titleToQuery = movieName.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(13, 13, 13, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
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
                    style: const TextStyle(
                      color: AppColors.yellow
                    ),
                    cursorColor: AppColors.yellow,
                    onChanged: (movieName) => updateQueryTitle(movieName),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GenreFilter(onUpdate: updateQueryGenre, selectedGenre: genreToQuery!)
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Planning",
              style: Theme.of(context).textTheme.displaySmall
            ),
          ),
          Expanded(
            child: PlanningMoviesList(key: UniqueKey(), movieTitle: titleToQuery, movieGenre: genreToQuery!)
          )
        ],
      ),
    );
  }
}