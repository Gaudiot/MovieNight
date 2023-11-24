class Movie implements Comparable<Movie>{
  late String _imdbId;
  final String title;
  final int year;
  final String synopsis;
  final int runtime;
  final List<String> genres;
  final double rating;
  late String posterPath;

  bool watched = false;
  bool favorite = false;

  Movie({
    required imdbId,
    required this.title,
    required this.year,
    required this.runtime,
    required this.genres,
    required this.rating,
    this.synopsis = "No available synopsis for this movie.",
    this.watched = false,
    this.favorite = false,
    this.posterPath = "https://www.altavod.com/assets/images/poster-placeholder.png"
    // this.posterPath = "https://d994l96tlvogv.cloudfront.net/uploads/film/poster/poster-image-coming-soon-placeholder-no-logo-500-x-740_29376.png"
  }){
    setImdbId(imdbId);
  }

  void setImdbId(String newImdbId){
    _imdbId = newImdbId;
  }

  String getImdbId(){
    return _imdbId;
  }

  @override
  int compareTo(Movie other){
    if(rating < other.rating) return 1;
    if(rating == other.rating) return 0;
    return -1;
  }

  factory Movie.fromMap(Map map){
    Movie movie = Movie(
      imdbId: map['imdbId'],
      title: map['title'],
      year: map['year'],
      runtime: map['runtime'], 
      genres: List<String>.from(map['genres']), 
      rating: map['rating'],
      synopsis: map['synopsis'],
      watched: map['watched'],
      favorite: map['favorite'],
      posterPath: map['posterPath']
    );

    return movie;
  }

  Map toMap(){
    return {
      'imdbId': _imdbId,
      'title': title,
      'year': year,
      'runtime': runtime,
      'genres': genres,
      'rating': rating,
      'synopsis': synopsis,
      'watched': watched,
      'favorite': favorite,
      'posterPath': posterPath
    };
  }
}