import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';

import 'package:movie_night/entities/movie/movie.dart';
import 'package:movie_night/repositories/movies_db/models/i_movie_repository.dart';
import 'package:movie_night/repositories/movies_db/movies_repository.dart';
import 'package:movie_night/routes/movie_detail/components/genre_item.dart';
import 'package:movie_night/shared/app_colors.dart';
import 'package:movie_night/utils/time_formatter.dart';

class MovieDetail extends StatefulWidget{
  final String movieId;

  const MovieDetail(this.movieId, {super.key});

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  final IMovieRepository movieRepository = MoviesRepository();
  Future<Movie?>? movie;

  @override
  void initState() {
    super.initState();
    movie = getMovie(widget.movieId);
  }

  Future<Movie?> getMovie(String movieId) async {
    if(movieId.isEmpty) return null;

    final movie = await movieRepository.getMovieById(movieId);
    return movie;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: movie,
      builder:(context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator());
        }
        
        final movie = snapshot.data;

        if(movie == null){
          return const Placeholder();
        }else{
          return Container(
            color: AppColors.blue,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => {context.pop()}, 
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
                    CachedNetworkImage(
                      imageUrl: movie.posterPath,
                      height: 250,
                      placeholder: (context, url) => const SizedBox(width: 167, height: 250, child: Placeholder()),
                      errorWidget: (context, url, error) => const SizedBox(width: 167, height: 250, child: Center(child: Icon(Icons.error))),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: AppColors.black,
                        ),
                        child: Column(
                          children: [
                            Text(movie.title, style: const TextStyle(
                              fontSize: 30,
                              color: AppColors.yellow
                              ),
                              overflow: TextOverflow.visible,
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(Icons.schedule, color: AppColors.white),
                                Text(timeFormatter(movie.runtime), style: const TextStyle(
                                  color: AppColors.white
                                )),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(Icons.star,  color: AppColors.white,),
                                Text(movie.rating.toStringAsFixed(2), style: const TextStyle(
                                  color: AppColors.white
                                )),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(Icons.calendar_month,  color: AppColors.white,),
                                Text("${movie.year}", style: const TextStyle(
                                  color: AppColors.white
                                )),
                              ],
                            )
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
                    fontWeight: FontWeight.w600,
                    color: AppColors.yellow
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Text(movie.synopsis, style: const TextStyle(
                    color: AppColors.white
                  ))
                )
              ],
            ),
          );
        }
      }
    );
  }
}

class _NoMovieFound extends StatelessWidget {
  const _NoMovieFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("An error occured, please try again later."),
    );
  }
}