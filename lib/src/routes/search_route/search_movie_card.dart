part of "package:movie_night/src/routes/search_route/search_route.dart";

class _SearchMovieCard extends StatelessWidget {
  final String title;
  final int year;
  final int runtimeInMinutes;
  final List<String> genres;
  final double rating;
  final String? imageUrl;

  final VoidCallback onAddToWatchlistPressed;
  final VoidCallback onWatchedPressed;

  final bool isAddedToWatchlist;
  final bool isWatched;

  const _SearchMovieCard({
    required this.title,
    required this.year,
    required this.runtimeInMinutes,
    required this.genres,
    required this.rating,
    required this.imageUrl,
    required this.onAddToWatchlistPressed,
    required this.onWatchedPressed,
    this.isAddedToWatchlist = false,
    this.isWatched = false,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 184,
        maxHeight: 200,
      ),
      child: Row(
        children: [
          _MoviePoster(
            imageUrl: imageUrl,
            rating: rating,
          ),
          const SizedBox(
            width: 18,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 23,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Text(
                        year.toString(),
                        style: const TextStyle(color: AppColors.white),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        formatDuration(runtimeInMinutes),
                        style: const TextStyle(color: AppColors.white),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Wrap(
                    spacing: 4,
                    children: genres
                        .take(3)
                        .map(
                          (genre) => Text(
                            genre,
                            style: const TextStyle(
                              color: AppColors.white,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const Spacer(),
                  _Buttons(
                    isAddedToWatchlist: isAddedToWatchlist,
                    isWatched: isWatched,
                    onAddToWatchlistPressed: onAddToWatchlistPressed,
                    onWatchedPressed: onWatchedPressed,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  final bool isAddedToWatchlist;
  final bool isWatched;
  final VoidCallback onAddToWatchlistPressed;
  final VoidCallback onWatchedPressed;

  const _Buttons({
    required this.isAddedToWatchlist,
    required this.isWatched,
    required this.onAddToWatchlistPressed,
    required this.onWatchedPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!isAddedToWatchlist && !isWatched) ...[
          UIButton(
            onPressed: onAddToWatchlistPressed,
            label: "Add Watchlist",
            suffixIcon: Assets.lib.assets.icons.addCircle.svg(
              width: 16,
              height: 16,
              colorFilter: const ColorFilter.mode(
                AppColors.yellow,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
        ],
        Visibility(
          visible: !isWatched,
          child: UIButton(
            onPressed: onWatchedPressed,
            label: "Add Watched",
            suffixIcon: Assets.lib.assets.icons.checkCircle.svg(
              width: 16,
              height: 16,
              colorFilter: const ColorFilter.mode(
                AppColors.yellow,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final String? imageUrl;
  final double rating;

  const _MoviePoster({
    required this.imageUrl,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          height: 184,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Builder(
            builder: (context) {
              if (imageUrl == null) {
                return Assets.lib.assets.images.posterPlaceholder.image();
              } else {
                return CachedNetworkImage(
                  imageUrl: imageUrl!,
                  placeholder: (context, url) =>
                      Assets.lib.assets.images.posterPlaceholder.image(),
                  errorWidget: (context, url, error) =>
                      Assets.lib.assets.images.posterPlaceholder.image(),
                );
              }
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.all(8),
          decoration: ShapeDecoration(
            color: AppColors.black.withOpacity(0.5),
            shape: const StadiumBorder(),
          ),
          padding: const EdgeInsets.all(4),
          child: Row(
            children: [
              Assets.lib.assets.icons.star.svg(
                width: 16,
                height: 16,
                colorFilter: const ColorFilter.mode(
                  AppColors.yellow,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 2),
              Text(
                rating.toString(),
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
