import "package:flutter/material.dart";
import "package:movie_night/repositories/movies_db/movies_repository.dart";
import "package:movie_night/routes/catalog_route/components/catalog_movies_list.dart";
import "package:movie_night/routes/catalog_route/components/hidden_movie.dart";
import "package:movie_night/shared/app_colors.dart";
import "package:movie_night/shared/https/https.dart";

class Catalog extends StatefulWidget{
  const Catalog({super.key});

  @override
  State<Catalog> createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  String movieTitleToQuery = "";
  MoviesRepository moviesRepository = MoviesRepository();
  final Https https = Https();

  void updateMovieTitleToQuery(String movieTitle){
    setState(() {
      movieTitleToQuery = movieTitle.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(13, 13, 13, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.black,
              ),
              child: TextField(
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.search, color: AppColors.yellow),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: "Search movie...",
                  hintStyle: TextStyle(color: AppColors.gray),
                ),
                style: const TextStyle(color: AppColors.yellow),
                cursorColor: AppColors.yellow,
                
                onSubmitted: updateMovieTitleToQuery,
              ),
            ),
          ),
          if(movieTitleToQuery == "twix") const HiddenMovie(),
          Expanded(
            child: CatalogMoviesList(key: UniqueKey(), movieTitle: movieTitleToQuery),
          ),
        ],
      ),
    );
  }
}