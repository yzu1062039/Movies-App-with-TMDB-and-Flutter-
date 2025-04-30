import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movie_tmdb/core/configs/router/app_router.gr.dart';
import 'package:movie_tmdb/core/constants/path_constants.dart';

@AutoRouterConfig(replaceInRouteName: 'View|Widget,Route')
/// Holds all the routes that are defined in the app
/// Used to generate the Router object
class AppRouter extends RootStackRouter {
  AppRouter();

  @override
  List<AutoRoute> get routes => [
    AdaptiveRoute(
      page: MasterRoute.page,
      path: PathConstants.master,
      initial: true,
      children: [
        AdaptiveRoute(
          page: MoviesRoute.page,
          path: PathConstants.movies,
          title: (_, __) => 'Movies',
        ),
        AdaptiveRoute(
          page: BookmarksRoute.page,
          path: PathConstants.bookmarks,
          title: (_, __) => 'Bookmarks',
        ),
      ],
    ),
    CustomRoute(
      page: MovieDetailRoute.page,
      path: PathConstants.movieDetail,
      duration: Duration(milliseconds: 800),
      reverseDuration: Duration(milliseconds: 800),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    ),
  ];
}
