import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:movie_night/entities/movie/movie.dart';
import 'package:movie_night/utils/time_formatter.dart';

class MovieInfo extends StatelessWidget {
  final Movie movie;
  const MovieInfo({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          // color: Colors.grey
        ),
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              // child: SingleChildScrollView(
              //   child: Text(movie.title, 
              //     style: Theme.of(context).textTheme.headlineMedium,
              //     // overflow: TextOverflow.fade,
              //   ),
              // ),
              child: AutoSizeText(movie.title,
                style: Theme.of(context).textTheme.headlineLarge,
                overflow: TextOverflow.clip,
              ),
            ),
            const SizedBox(height: 5),
            _DisplayInfo(icon: FontAwesomeIcons.clock, info: timeFormatter(movie.runtime)),
            const SizedBox(height: 5),
            _DisplayInfo(icon: FontAwesomeIcons.star, info: movie.rating.toStringAsFixed(2)),
            const SizedBox(height: 5),
            _DisplayInfo(icon: FontAwesomeIcons.calendar, info: movie.year.toString())
          ],
        ),
      ),
    );
  }
}

class _DisplayInfo extends StatelessWidget {
  final IconData icon;
  final String info;
  const _DisplayInfo({super.key, required this.icon, required this.info});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 35,
          width: 35,
          child: Center(child: FaIcon(icon))
        ),
        Text(info)
      ],
    );
  }
}