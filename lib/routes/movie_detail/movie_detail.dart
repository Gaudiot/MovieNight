import 'package:flutter/material.dart';
import 'package:movie_night/entities/movie.dart';
import 'package:movie_night/routes/movie_detail/components/genre_item.dart';
import 'package:movie_night/shared/app_colors.dart';
import 'package:movie_night/utils/time_formatter.dart';

class MovieDetail extends StatelessWidget{
  final Movie movie;

  const MovieDetail(this.movie, {super.key});
  
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.blue,
          centerTitle: true,
          title: Container(
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(20)
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.movie, color: AppColors.yellow),
                  SizedBox(width: 10),
                  Text("MOVIE NIGHT")
                ],
              ),
            ),
          ),
        ),
        body: Container(
          color: AppColors.blue,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => {Navigator.pop(context)}, 
                    icon: const Icon(Icons.arrow_back, color: AppColors.white)
                  ),
                  Expanded(
                    child: Text(
                      movie.title, 
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 20
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Image.network(movie.posterPath, height: 250),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      color: AppColors.gray,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(movie.title),
                          Text(timeFormatter(movie.runtime))
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Wrap(
                  spacing: 5,
                  children: [
                    for(String genre in movie.genres)
                      GenreItem(genre)
                  ]
                ),
              ),
              const Text(
                "Synopsis",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.gray,
                  borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                padding: const EdgeInsets.all(10),
                child: Text(movie.synopsis)
              )
            ],
          ),
        ),
      ),
    );
  }
}