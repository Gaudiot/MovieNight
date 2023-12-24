import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:movie_night/shared/https/https.dart';
import 'package:movie_night/entities/movie/movie.dart';
import 'package:movie_night/routes/catalog_route/components/catalog_movie_card.dart';

class CatalogMoviesList extends StatefulWidget {
  final String movieTitle;
  const CatalogMoviesList({super.key, required this.movieTitle});

  @override
  State<CatalogMoviesList> createState() => _CatalogMoviesListState();
}

class _CatalogMoviesListState extends State<CatalogMoviesList> {
  final int _numberOfMoviesPerRequest = 10;

  final PagingController<int, Movie> _pagingController = PagingController(firstPageKey: 1);
  
  @override
  void initState(){
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final movies = await Https().getMoviesByTitle(widget.movieTitle, page: pageKey, limit: _numberOfMoviesPerRequest);
      final isLastPage = movies.length < _numberOfMoviesPerRequest;

      if(isLastPage){
        _pagingController.appendLastPage(movies);
      }else{
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(movies, nextPageKey);
      }
    } catch (e) {
      debugPrint("error --> $e");
      _pagingController.error = e;
    }
  }

  @override
  Widget build(BuildContext context) {
    if(widget.movieTitle.isEmpty){
      return const _NoMovieSearch();
    }

    return RefreshIndicator(
      onRefresh: () => Future.sync(() => _pagingController.refresh()),
      child: PagedListView<int, Movie>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Movie>(
          itemBuilder: (context, movie, index) {
            return CatalogMovieCard(movie: movie);
          },
          noItemsFoundIndicatorBuilder: (context){
            return const _NoMoviesFound();
          },
          firstPageErrorIndicatorBuilder: (context) => const _ErrorFetchingData(),
          newPageErrorIndicatorBuilder: (context) => const _ErrorFetchingData()
        ),
      )
    );
  }
}

class _NoMovieSearch extends StatelessWidget {
  const _NoMovieSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/popcorn_bucket.png',
          height: 300,
        ),
        Text("What movie you want to watch next?",
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _NoMoviesFound extends StatelessWidget {
  const _NoMoviesFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/no_movie.png',
          height: 300,
        ),
        Text("Sorry, we couldn't find the movie with that title.",
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _ErrorFetchingData extends StatelessWidget {
  const _ErrorFetchingData({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("An error occured while fetching the data");
  }
}