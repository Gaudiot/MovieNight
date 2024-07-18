part of "package:movie_night/src/base/network/apis/movie_api/tmdb/tmdb_api.dart";

List<String> _getMoviesIdsFromJson(dynamic json) {
  final List<dynamic> moviesJson = json["results"];
  final List<String> moviesIds = moviesJson
      .map(
        (movieData) => (movieData["id"] as int).toString(),
      )
      .toList();

  return moviesIds;
}

Movie _getMovieDetailsFromJson(dynamic json) {
  return Movie(
    id: (json["id"] as int).toString(),
    title: json["title"] as String,
    synopsis: json["overview"] as String,
    poster: json["poster_path"] as String,
    backdropPoster: json["backdrop_path"] as String,
    rating: json["vote_average"] as double,
    releaseDate: DateTime.parse(json["release_date"]),
    runtime: json["runtime"] as int,
    genres: List<String>.from(json["genres"].map((x) => x["name"])),
  );
}

List<Streaming> _getMovieStreamingsFromJson(dynamic json) {
  final dynamic streamingsJson = json["results"]["BR"];

  if (streamingsJson == null) {
    return [];
  }

  final List<dynamic> streamingsListJson = streamingsJson["flatrate"];
  final List<Streaming> streamings = streamingsListJson
      .map(
        (streamingData) => Streaming(
          name: streamingData["provider_name"] as String,
          logoUrl: streamingData["logo_path"] as String,
        ),
      )
      .toList();

  return streamings;
}

String _getMovieTrailerFromJson(dynamic json) {
  final List<dynamic> videos = json["results"];

  if (videos.isEmpty) {
    return "";
  }

  try {
    final dynamic trailer = videos.firstWhere(
      (video) => (video["site"] == "YouTube" && video["type"] == "Trailer"),
    );

    return trailer["key"] as String;
  } catch (e) {
    return "";
  }
}
