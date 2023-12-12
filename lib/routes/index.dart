import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:movie_night/routes/catalog_route/catalog.dart';
import 'package:movie_night/routes/planning_route/planning.dart';
import 'package:movie_night/routes/watched_route/watched.dart';

final appRouterConfig = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) => '/watched',
    ),
    GoRoute(
      path: '/catalog',
      // builder: (context, state) => const _BaseLayout(child: Catalog()),
      builder: (context, state) =>const _BaseLayout(child: Catalog())
    ),
    GoRoute(
      path: '/planning',
      builder: (context, state) =>const _BaseLayout(child: Planning())
    ),
    GoRoute(
      path: '/watched',
      builder: (context, state) =>const _BaseLayout(child: Watched())
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) =>const _BaseLayout(child: Text("Profile"))
    ),
    GoRoute(
      path: '/movie/:movieId',
      builder: (context, state) => const Placeholder(),
    ),
  ]
);

class _BaseLayout extends StatelessWidget {
  final Widget child;
  const _BaseLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: child,
      ),
    );
  }
}