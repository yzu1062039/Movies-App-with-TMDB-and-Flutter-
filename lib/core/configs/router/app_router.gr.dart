// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:movie_tmdb/domain/entities/export_entities.dart' as _i7;
import 'package:movie_tmdb/presentation/pages/bookmarks_view.dart' as _i1;
import 'package:movie_tmdb/presentation/pages/master_view.dart' as _i2;
import 'package:movie_tmdb/presentation/pages/movie_detail_view.dart' as _i3;
import 'package:movie_tmdb/presentation/pages/movies_view.dart' as _i4;

/// generated route for
/// [_i1.BookmarksView]
class BookmarksRoute extends _i5.PageRouteInfo<void> {
  const BookmarksRoute({List<_i5.PageRouteInfo>? children})
    : super(BookmarksRoute.name, initialChildren: children);

  static const String name = 'BookmarksRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.BookmarksView();
    },
  );
}

/// generated route for
/// [_i2.MasterView]
class MasterRoute extends _i5.PageRouteInfo<void> {
  const MasterRoute({List<_i5.PageRouteInfo>? children})
    : super(MasterRoute.name, initialChildren: children);

  static const String name = 'MasterRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.MasterView();
    },
  );
}

/// generated route for
/// [_i3.MovieDetailView]
class MovieDetailRoute extends _i5.PageRouteInfo<MovieDetailRouteArgs> {
  MovieDetailRoute({
    _i6.Key? key,
    required _i7.MovieDetailEntity? movieDetail,
    required Object heroTag,
    List<_i5.PageRouteInfo>? children,
  }) : super(
         MovieDetailRoute.name,
         args: MovieDetailRouteArgs(
           key: key,
           movieDetail: movieDetail,
           heroTag: heroTag,
         ),
         initialChildren: children,
       );

  static const String name = 'MovieDetailRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MovieDetailRouteArgs>();
      return _i3.MovieDetailView(
        key: args.key,
        movieDetail: args.movieDetail,
        heroTag: args.heroTag,
      );
    },
  );
}

class MovieDetailRouteArgs {
  const MovieDetailRouteArgs({
    this.key,
    required this.movieDetail,
    required this.heroTag,
  });

  final _i6.Key? key;

  final _i7.MovieDetailEntity? movieDetail;

  final Object heroTag;

  @override
  String toString() {
    return 'MovieDetailRouteArgs{key: $key, movieDetail: $movieDetail, heroTag: $heroTag}';
  }
}

/// generated route for
/// [_i4.MoviesView]
class MoviesRoute extends _i5.PageRouteInfo<void> {
  const MoviesRoute({List<_i5.PageRouteInfo>? children})
    : super(MoviesRoute.name, initialChildren: children);

  static const String name = 'MoviesRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.MoviesView();
    },
  );
}
