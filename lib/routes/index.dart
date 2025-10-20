import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:go_router/go_router.dart";
import "package:movie_night/routes/catalog_route/catalog.dart";
import "package:movie_night/routes/movie_detail/movie_detail.dart";
import "package:movie_night/routes/planning_route/planning.dart";
import "package:movie_night/routes/profile_route/profile.dart";
import "package:movie_night/routes/watched_route/watched.dart";
import "package:movie_night/shared/app_colors.dart";
import "package:movie_night/shared/pages.dart";
import "package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart";

final appRouterConfig = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const _TabsLayout(),
    ),
    GoRoute(
      path: "/movie/:movieId",
      builder: (context, state){
        final String movieId = state.pathParameters["movieId"]!;

        return _BaseLayout(child: MovieDetail(movieId));
      },
    ),
  ],
);

class _BaseLayout extends StatelessWidget {
  final Widget child;
  const _BaseLayout({required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: child,
      ),
    );
  }
}

class _TabsLayout extends StatefulWidget {
  const _TabsLayout({super.key});

  @override
  State<_TabsLayout> createState() => _TabsLayoutState();
}

class _TabsLayoutState extends State<_TabsLayout> {
  final PersistentTabController _persistentTabController = PersistentTabController();

  @override
  void dispose() {
    _persistentTabController.dispose();
    super.dispose();
  }

  final List<Widget> _screens = [
    const Catalog(),
    const Planning(),
    const Watched(),
    const Profile(),
  ];

  final List<PersistentBottomNavBarItem> _items = [
    PersistentBottomNavBarItem(
      icon: FaIcon(Pages.catalog.icon),
      title: Pages.catalog.name,
      activeColorPrimary: Colors.orange,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: FaIcon(Pages.planning.icon),
      title: Pages.planning.name,
      activeColorPrimary: Colors.orange,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: FaIcon(Pages.watched.icon),
      title: Pages.watched.name,
      activeColorPrimary: Colors.orange,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: FaIcon(Pages.profile.icon),
      title: Pages.profile.name,
      activeColorPrimary: Colors.orange,
      inactiveColorPrimary: Colors.grey,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PersistentTabView(context,
        screens: _screens,
        items: _items,
        backgroundColor: AppColors.black,
        stateManagement: false,
      ),
    );
  }
}