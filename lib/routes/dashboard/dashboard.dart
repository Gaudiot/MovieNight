import 'package:flutter/material.dart';
import 'package:movie_night/routes/dashboard/components/bottom_bar.dart';
import 'package:movie_night/routes/dashboard/subroutes/catalog_route/catalog.dart';
import 'package:movie_night/routes/dashboard/subroutes/planning_route/planning.dart';
import 'package:movie_night/routes/dashboard/subroutes/profile_route/profile.dart';
import 'package:movie_night/routes/dashboard/subroutes/watched_route/watched.dart';
import 'package:movie_night/shared/app_colors.dart';

class Dashboard extends StatefulWidget{
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedPage = 0;

  List<Widget> pages = <Widget>[const Catalog(), const Planning(), const Watched(), const Profile()];

  void selectPage(int page){
    setState(() {
      selectedPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        centerTitle: true,
        title: Container(
          decoration: BoxDecoration(
            color: AppColors.black,
            borderRadius: BorderRadius.circular(20)
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.movie, color: AppColors.yellow),
                SizedBox(width: 10),
                Text("MOVIE NIGHT")
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.blue
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: pages[selectedPage],
          ),
        )
      ),
      bottomNavigationBar: BottomBar(onTap: selectPage, selectedPage: selectedPage,),
    );
  }
}

