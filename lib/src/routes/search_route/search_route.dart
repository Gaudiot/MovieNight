import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:movie_night/gen/assets.gen.dart";
import "package:movie_night/injections.dart";
import "package:movie_night/src/base/network/apis/movie_api/movie_api.dart";
import "package:movie_night/src/base/widgets/delayed_search_bar.dart";
import "package:movie_night/src/base/widgets/ui_button.dart";
import "package:movie_night/src/core/data/models/models.dart";
import "package:movie_night/src/core/design/design.dart";
import "package:movie_night/src/core/exceptions/exceptions.dart";
import "package:movie_night/src/core/types/result_type.dart";
import "package:movie_night/src/shared/utils/utils.dart";

part "package:movie_night/src/routes/search_route/search_display_list.dart";
part "package:movie_night/src/routes/search_route/search_movie_card.dart";

class _MovieData {
  final Movie movie;
  bool isAddedToWatchlist;
  bool isWatched;

  _MovieData({
    required this.movie,
    required this.isAddedToWatchlist,
    required this.isWatched,
  });
}

class SearchRoute extends StatefulWidget {
  const SearchRoute({super.key});

  @override
  State<SearchRoute> createState() => _SearchRouteState();
}

class _SearchRouteState extends State<SearchRoute> {
  final movieApi = getIt<IMovieApi>();

  String queryMovieTitle = "";

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.darkestBlue,
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 20),
        child: Column(
          children: [
            DelayedSearchBar(
              onSearch: (value) {
                setState(() {
                  queryMovieTitle = value;
                });
              },
            ),
            _HeaderFilter(
              movieTitle: queryMovieTitle,
            ),
            Expanded(
              child: _SearchDisplayList(
                key: ValueKey(queryMovieTitle),
                queryMovieTitle: queryMovieTitle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderFilter extends StatelessWidget {
  final String movieTitle;

  const _HeaderFilter({
    this.movieTitle = "",
  });

  @override
  Widget build(BuildContext context) {
    final String displayedText = movieTitle.isEmpty ? "Trending" : "Results";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Row(
        children: [
          Text(
            displayedText,
            style: const TextStyle(color: AppColors.white),
          ),
          const Spacer(),
          const Text(
            "Category",
            style: TextStyle(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
