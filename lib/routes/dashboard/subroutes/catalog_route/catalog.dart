import 'package:flutter/material.dart';
import 'package:movie_night/routes/dashboard/subroutes/catalog_route/components/no_movies.dart';
import 'package:movie_night/shared/app_colors.dart';
import 'package:movie_night/entities/movie.dart';
import 'package:movie_night/repositories/movies_db/movies_repository.dart';
import 'package:movie_night/routes/dashboard/subroutes/catalog_route/components/catalog_movie_card.dart';
import 'package:movie_night/routes/dashboard/subroutes/catalog_route/components/hidden_movie.dart';
import 'package:movie_night/routes/dashboard/subroutes/catalog_route/components/no_wifi_connexion.dart';
import 'package:movie_night/services/apis/tmdb_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Catalog extends StatefulWidget{
  const Catalog({super.key});

  @override
  State<Catalog> createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  String movieTitleToQuery = "";
  MoviesRepository moviesRepository = MoviesRepository();
  
  Future<List<Movie>> getMovies() async {
    if(movieTitleToQuery.isEmpty) return [];

    List<Movie> movies = await TmdbApi().getMovies(movieName: movieTitleToQuery, page: 1);
    return movies;
  }

  void updateMovieTitleToQuery(String movieTitle){
    setState(() {
      movieTitleToQuery = movieTitle.toLowerCase();
    });
  }

  Future<void> cleanCache() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList("@MovieNight/movies", []);
    
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Clear Cache"),
      duration: Duration(seconds: 3),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
              
              onSubmitted: updateMovieTitleToQuery
            ),
          ),
        ),
        if(movieTitleToQuery == "twix") const HiddenMovie(),
        Expanded(
          child: FutureBuilder(
            future: getMovies(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator());
              }
              if(snapshot.hasError){
                return const NoWifiConnexion();
              }
              
              List<Movie> movies = snapshot.requireData;

              if(movies.isEmpty){
                return const NoMovies();
              }
              return Container(
                decoration: const BoxDecoration(color: AppColors.blue),
                child: ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    Movie movie = movies[index];
              
                    return CatalogMovieCard(movie: movie);
                  },
                ),
              );
            },
          ),
        )
      ],
    );
  }
}