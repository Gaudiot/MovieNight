import 'package:flutter/material.dart';
import 'package:movie_night/shared/app_colors.dart';
import 'package:movie_night/entities/movie.dart';
import 'package:movie_night/repositories/movies_db/movies_repository.dart';
import 'package:movie_night/routes/dashboard/subroutes/planning_route/components/genre_filter.dart';
import 'package:movie_night/routes/dashboard/subroutes/planning_route/components/planning_movie_card.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
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
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "Planning",
            style: TextStyle(color: AppColors.yellow, fontSize: 32),
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: MoviesRepository.findMoviesWhere(title: titleToQuery, genrer: genreToQuery, watched: false),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator());
              }
              if(!snapshot.hasData){
                return const Text("NO MOVIES");
              }
              if(snapshot.hasError){
                return Text("ERROR DETECTED ${snapshot.error} ${snapshot.hasError}");
              }

              List<Movie> movies = snapshot.requireData;
              movies.sort();

              return ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index){
                  final Movie movie = movies[index];
                  return PlanningMovieCard(
                    movie: movie, 
                    onAction: (){setState(() {});}
                  ); 
                }
              );
            }
          ),
        )
      ],
    );
  }
}