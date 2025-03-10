import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_night/shared/https/implementations/apis/tmdb_api.dart';

class StreamingList extends StatefulWidget {
  final String movieId;
  const StreamingList({super.key, required this.movieId});

  @override
  State<StreamingList> createState() => _StreamingListState();
}

class _StreamingListState extends State<StreamingList> {
  Future<List<String>>? streamings;

  @override
  void initState() {
    super.initState();
    streamings = getMovieStreamings();
  }

  Future<List<String>> getMovieStreamings() async {
    final streamings = await TmdbApi().getMovieStreamings(movieId: widget.movieId);
    return streamings;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Streamings", style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 4),
        FutureBuilder(
          future: streamings,
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Text("No streamings found");
            }
        
            final streamings = snapshot.data!;

            if(streamings.isEmpty){
              return const Text("No streamings found");
            }

            return Wrap(
              spacing: 10,
              children: [
                for(String streaming in streamings)
                  CachedNetworkImage(
                    imageUrl: "https://media.themoviedb.org/t/p/original/$streaming",
                    height: 50,
                    placeholder: (context, url) => const SizedBox(width: 50, height: 50, child: Placeholder()),
                    errorWidget: (context, url, error) => const SizedBox(width: 50, height: 50, child: Center(child: Icon(Icons.error))),
                  ),
              ],
            );
          },
        )
      ],
    );
  }
}