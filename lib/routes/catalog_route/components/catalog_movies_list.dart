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
    return RefreshIndicator(
      onRefresh: () => Future.sync(() => _pagingController.refresh()),
      child: PagedListView<int, Movie>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Movie>(
          itemBuilder: (context, movie, index) {
            return CatalogMovieCard(movie: movie);
          },
          noItemsFoundIndicatorBuilder: (context){
            return (widget.movieTitle.isEmpty ? const _NoMovieSearch() : const _NoMoviesFound());
          },
          firstPageErrorIndicatorBuilder: (context) => const _ErrorFetchingData(),
          newPageErrorIndicatorBuilder: (context) => const _ErrorFetchingData(),
        ),
      )
    );
  }
}

class _NoMovieSearch extends StatelessWidget {
  const _NoMovieSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Search for a movie to have fun!")
    );
  }
}

class _NoMoviesFound extends StatelessWidget {
  const _NoMoviesFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("No movies found with the given name.")
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