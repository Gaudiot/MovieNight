import 'package:flutter/material.dart';
import 'package:movie_night/shared/app_colors.dart';

class BottomBar extends StatelessWidget{
  final Function(int value) onTap;
  final int selectedPage;

  const BottomBar({super.key, required this.onTap, required this.selectedPage});

  final List<BottomNavigationBarItem> tabItems = const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.subscriptions),
          label: "Catalog"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_movies),
          label: "Planning"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.remove_red_eye),
          label: "Watched"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          label: "Profile"
        )
      ];
  
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.black,
      items: tabItems,
      currentIndex: selectedPage,
      selectedItemColor: AppColors.yellow,
      unselectedItemColor: AppColors.white,
      onTap: onTap,
    );
  }
}