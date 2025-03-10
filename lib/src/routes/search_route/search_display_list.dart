part of "package:movie_night/src/routes/search_route/search_route.dart";

class _SearchDisplayList extends StatefulWidget {
  final String queryMovieTitle;

  const _SearchDisplayList({
    required this.queryMovieTitle,
    super.key,
  });

  @override
  State<_SearchDisplayList> createState() => _SearchDisplayListState();
}

class _SearchDisplayListState extends State<_SearchDisplayList> {
  late bool isLastPage;
  late int page;
  late bool hasError;
  late bool isLoading;
  final int pageSize = 20;
  late List<_MovieData> movies;
  final int pageTrigger = 5;

  final movieApi = getIt<IMovieApi>();

  @override
  void initState() {
    page = 1;
    movies = [];
    isLastPage = false;
    hasError = false;
    isLoading = true;
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchData() async {
    isLoading = true;
    final Result<List<Movie>, NetworkException> result;

    if (widget.queryMovieTitle.isEmpty) {
      result = await movieApi.discoverMovies(
        page: page,
        limit: pageSize,
      );
    } else {
      result = await movieApi.getMovies(
        name: widget.queryMovieTitle,
        page: page,
        limit: pageSize,
      );
    }

    if (result.hasError || result.value == null) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
      return;
    }

    final movies = result.value!;

    final newMovies = movies.map((movie) {
      return _MovieData(
        movie: movie,
        isAddedToWatchlist: false,
        isWatched: false,
      );
    }).toList();

    if (mounted) {
      setState(() {
        this.movies.addAll(newMovies);
        isLoading = false;
        isLastPage = movies.length < pageSize;
        page++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (hasError) {
      return const _SearchErrorWidget();
    } else if (isLoading && movies.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (!isLoading && movies.isEmpty) {
      return const _NoMoviesWidget();
    } else {
      return ListView.separated(
        itemCount: movies.length + 1,
        itemBuilder: (context, index) {
          if (index == movies.length - pageTrigger) {
            fetchData();
          }
          if (index == movies.length) {
            if (hasError) {
              return const Center(
                child: Text(
                  "An error occurred",
                ),
              );
            } else if (isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.white,
                ),
              );
            } else {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Fim da lista",
                  style: TextStyle(
                    color: AppColors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }
          }
          final movieData = movies[index];
          final movie = movieData.movie;

          return _SearchMovieCard(
            title: movie.title,
            year: movie.releaseDate.year,
            runtimeInMinutes: movie.runtime,
            genres: movie.genres,
            rating: movie.rating,
            imageUrl: movie.poster,
            isAddedToWatchlist: movieData.isAddedToWatchlist,
            isWatched: movieData.isWatched,
            onAddToWatchlistPressed: () {
              setState(() {
                movies[index].isAddedToWatchlist =
                    !movieData.isAddedToWatchlist;
              });
            },
            onWatchedPressed: () {
              setState(() {
                movies[index].isWatched = !movieData.isWatched;
              });
            },
          );
        },
        separatorBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 18),
            child: Divider(
              color: AppColors.gray,
              thickness: 2,
              height: 2,
            ),
          );
        },
      );
    }
  }
}

class _SearchErrorWidget extends StatelessWidget {
  const _SearchErrorWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.lib.assets.icons.closedTicketBooth.svg(
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          const SizedBox(
            height: 26,
          ),
          const Text(
            "Oops! Something went wrong. Please try again later.",
            style: TextStyle(
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _NoMoviesWidget extends StatelessWidget {
  const _NoMoviesWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.lib.assets.icons.emptyPopcorn.svg(
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          const SizedBox(
            height: 26,
          ),
          const Text(
            "Sorry, we couldn't find the movies you are looking for.",
            style: TextStyle(
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
