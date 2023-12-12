import 'package:flutter/material.dart';
import 'package:movie_night/shared/app_colors.dart';

List<String> genres = [
  "All",
  "Action",
  "Adventure",
  "Animation",
  "Biography",
  "Comedy",
  "Crime",
  "Documentary",
  "Drama",
  "Family",
  "Fantasy",
  "Film-Noir",
  "History",
  "Horror",
  "Music",
  "Musical",
  "Mystery",
  "Romance",
  "Sci-Fi",
  "Short",
  "Sport",
  "Thriller",
  "War",
  "Western"
];

class GenreFilter extends StatelessWidget{
  final Function(String?) onUpdate;
  final String selectedGenre;

  const GenreFilter({super.key, required this.onUpdate, required this.selectedGenre});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColors.black
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          style: const TextStyle(color: AppColors.black),
          items: genres.map<DropdownMenuItem<String>>((String genre){
            return DropdownMenuItem<String>(
              value: genre,
              child: Text(genre, style: const TextStyle(color: AppColors.white)),
            );
          }).toList(),
          dropdownColor: AppColors.black,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          
          value: selectedGenre,
          onChanged: onUpdate,
        ),
      ),
    );
  }
}