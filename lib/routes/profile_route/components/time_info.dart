import 'package:flutter/material.dart';

import 'package:movie_night/entities/movie/movie.dart';
import 'package:movie_night/repositories/movies_db/movies_repository.dart';
import 'package:movie_night/shared/app_colors.dart';
import 'package:movie_night/utils/time_formatter.dart';

class TimeInfo extends StatelessWidget{
  const TimeInfo({super.key});

  Future<Map<String, int>> info() async{
    final List<Movie> movies = await MoviesRepository().getMovies(watched: true);

    int moviesSize = movies.length;
    int moviesTotalTime = movies.fold<int>(0, (previousValue, movie) => previousValue + movie.runtime);

    Map<String, int> result = {
      "quantity": moviesSize,
      "totalTime": moviesTotalTime
    };

    return result;
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
          style: Theme.of(context).textTheme.headlineSmall!.apply(
            color: AppColors.yellow
          )
        ),
        Text(
          info,
          style: Theme.of(context).textTheme.titleLarge
        ),
      ],
    );
  }
}