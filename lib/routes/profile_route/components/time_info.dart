import 'package:flutter/material.dart';
import 'package:movie_night/entities/movie/movie.dart';
import 'package:movie_night/repositories/movies_db/movies_repository.dart';
import 'package:movie_night/shared/app_colors.dart';
import 'package:movie_night/utils/time_formatter.dart';

class TimeInfo extends StatelessWidget{
  const TimeInfo({super.key});

  Future<Map<String, int>> info() async{
    // List<Movie> movies = await MoviesRepository.findMoviesWhere(watched: true);
    List<Movie> movies = [];

    int moviesSize = movies.length;
    int moviesTotalTime = movies.fold<int>(0, (previousValue, movie) => previousValue + movie.runtime);

    Map<String, int> teste = {
      "quantity": moviesSize,
      "totalTime": moviesTotalTime
    };

    return teste;
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.all(Radius.circular(5.0))
      ),
      child: FutureBuilder(
        future: info(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          if(snapshot.hasError){
            return const Text("Error");
          }

          Map<String, int> movies = snapshot.requireData;

          String moviesWatched = movies['quantity'].toString();
          String timeSpent = timeFormatter(movies['totalTime'] ?? 0);

          return Column(
            children: [
              _TimeField("Movies Watched: ", moviesWatched),
              _TimeField("Time Spent: ", timeSpent)
            ],
          );
        },
      ),
    );
  }
}

class _TimeField extends StatelessWidget{
  final String title;
  final String info;

  const _TimeField(this.title, this.info);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title, 
          style: const TextStyle(color: AppColors.yellow, fontSize: 20),
        ),
        Text(
          info, 
          style: const TextStyle(color: AppColors.gray, fontSize: 20),
        ),
      ],
    );
  }
}