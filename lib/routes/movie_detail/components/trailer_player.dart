import 'package:flutter/material.dart';
import 'package:movie_night/shared/https/implementations/apis/tmdb_api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerPlayer extends StatefulWidget {
  final String movieId;
  const TrailerPlayer({super.key, required this.movieId});

  @override
  State<TrailerPlayer> createState() => _TrailerPlayerState();
}

class _TrailerPlayerState extends State<TrailerPlayer> {
  Future<List<String>>? movieTrailerIds;

  @override
  void initState() {
    super.initState();
    movieTrailerIds = TmdbApi().getMovieTrailerIds(movieId: widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: movieTrailerIds,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Placeholder();
        }

        final String movieTrailerId = snapshot.data![0];

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Trailer", style: Theme.of(context).textTheme.headlineMedium),
            _TrailerYoutubePlayer(trailerId: movieTrailerId),
          ],
        );
      },
    );
  }
}

class _TrailerYoutubePlayer extends StatefulWidget {
  final String trailerId;

  const _TrailerYoutubePlayer({required this.trailerId});

  @override
  State<_TrailerYoutubePlayer> createState() => _TrailerYoutubePlayerState();
}

class _TrailerYoutubePlayerState extends State<_TrailerYoutubePlayer> {
  late YoutubePlayerController _youtubePlayerController;

  @override
  void initState() {
    super.initState();
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: widget.trailerId,
      flags: const YoutubePlayerFlags(
        autoPlay: false
      )
    );
  }

  @override
  void deactivate() {
    _youtubePlayerController.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _youtubePlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _youtubePlayerController,
        showVideoProgressIndicator: true,
      ),
      builder: (context, player) {
          return Column(
            children: [player],
          );
      },
    );
  }
}