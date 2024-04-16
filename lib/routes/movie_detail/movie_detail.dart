import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:movie_night/entities/movie/movie.dart';
import 'package:movie_night/repositories/movies_db/models/i_movie_repository.dart';
import 'package:movie_night/repositories/movies_db/movies_repository.dart';
import 'package:movie_night/routes/movie_detail/components/display_genres.dart';
import 'package:movie_night/routes/movie_detail/components/movie_info.dart';
import 'package:movie_night/routes/movie_detail/components/streaming_list.dart';
import 'package:movie_night/routes/movie_detail/components/trailer_player.dart';
import 'package:movie_night/shared/https/https.dart';

class MovieDetail extends StatefulWidget{
  final String movieId;

  const MovieDetail(this.movieId, {super.key});

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  final IMovieRepository movieRepository = MoviesRepository();
  late Future<Movie?> movie;

  @override
  void initState() {
    super.initState();
    movie = getMovie(widget.movieId);
  }
  
  @override
  void dispose(){
    super.dispose();
  }

  Future<Movie?> getMovie(String movieId) async {
    if(movieId.isEmpty) return null;

    final Movie? movie = await Https().getMovieById(movieId);
    return movie;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // future: Future.wait([getMovie(widget.movieId), TmdbApi().getMovieTrailerIds(movieId: widget.movieId)]),
      future: movie,
      builder:(context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator());
        }
        
        final movie = snapshot.data;

        if(movie == null){
          return const Column(
            children: [
              _BackBar("No movie found"),
              Expanded(
                child: Center(
                  child: _NoMovieFound()
                )
              ),
            ],
          );
        }

        return Container(
          margin: const EdgeInsets.all(20),
          child: Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _BackBar(movie.title),
                Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: movie.posterPath,
                      height: 250,
                      placeholder: (context, url) => const SizedBox(width: 167, height: 250, child: Placeholder()),
                      errorWidget: (context, url, error) => const SizedBox(width: 167, height: 250, child: Center(child: Icon(Icons.error))),
                    ),
                    const SizedBox(width: 20),
                    MovieInfo(movie: movie)
                  ],
                ),
                DisplayGenres(movie.genres),
                StreamingList(movieId: movie.imdbId),
                _Synopsis(movie.synopsis),
              ],
            ),
          ),
        );
      }
    );
  }
}

class _BackBar extends StatelessWidget {
  final String text;
  const _BackBar(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => {context.pop()}, 
          icon: const FaIcon(FontAwesomeIcons.arrowLeft)
        ),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleLarge,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}

class _Synopsis extends StatelessWidget {
  final String movieSynopsis;
  const _Synopsis(this.movieSynopsis, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Synopsis", style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 10),
          Text(movieSynopsis)
        ],
      ),
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