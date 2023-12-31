import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:movie_night/repositories/movies_db/movies_repository.dart';
import 'package:movie_night/routes/profile_route/components/time_info.dart';
import 'package:movie_night/shared/app_colors.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const TimeInfo(),
          _EraseDataButton()
        ],
      ),
    );
  }
}

class _EraseDataButton extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(AppColors.red),
      ),
      onPressed: () => showDialog<String>(
        context: context, 
        builder: ((BuildContext context) => _EraseDataDialog())
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(FontAwesomeIcons.solidTrashCan, color: AppColors.white),
          Text("Erase All Data",
            style: Theme.of(context).textTheme.labelLarge,
          )
        ],
      ),
    );
  }
}

class _EraseDataDialog extends StatelessWidget {
  _EraseDataDialog({super.key});

  final MoviesRepository moviesRepository = MoviesRepository();

  Future<void> _eraseMovieData() async{
    await moviesRepository.clearMovies();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Careful!"),
      content: const Text("By confirming, all your movie related data will be ERASED from the app, are you sure you want to proceed?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: const Text("Cancel")
        ),
        TextButton(
          onPressed: () => {
            Navigator.pop(context),
            _eraseMovieData()
          }, 
          child: const Text("Confirm")
        )
      ],
    );
  }
}