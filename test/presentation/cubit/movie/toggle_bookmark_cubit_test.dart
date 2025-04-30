import 'package:bloc_test/bloc_test.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_tmdb/core/exceptions/database/database_exception.dart';
import 'package:movie_tmdb/domain/entities/export_entities.dart';
import 'package:movie_tmdb/domain/usecases/export_usecases.dart';
import 'package:movie_tmdb/presentation/bloc/movie/export_movie_cubits.dart';

import '../../../_utils/mocks/mocks.mocks.dart';

void main() {
  late final MovieUsecases mockMovieUsecases;

  late final MovieDetailEntity tMovieDetailEntity;

  setUpAll(() {
    mockMovieUsecases = MockMovieUsecases();

    tMovieDetailEntity = const MovieDetailEntity(
      id: 1,
      title: 'title',
      overview: 'overview',
      posterPath: 'posterPath',
      backdropPath: 'backdropPath',
    );
  });

  blocTest<ToggleBookmarkCubit, ToggleBookmarkState>(
    'should emit [ToggleBookmarkLoading, ToggleBookmarkLoaded] when success',
    setUp: () {
      provideDummy<Either<DatabaseException, void>>(const Right(null));

      when(
        mockMovieUsecases.toggleBookmark(movieDetailEntity: tMovieDetailEntity),
      ).thenAnswer((_) async => const Right(null));
    },
    build: () => ToggleBookmarkCubit(mockMovieUsecases),
    act:
        (ToggleBookmarkCubit cubit) =>
            cubit.toggleBookmark(movieDetailEntity: tMovieDetailEntity),
    expect:
        () => [const ToggleBookmarkLoading(), const ToggleBookmarkSuccess()],
    verify: (_) {
      verify(
        mockMovieUsecases.toggleBookmark(movieDetailEntity: tMovieDetailEntity),
      ).called(1);
    },
  );

  blocTest<ToggleBookmarkCubit, ToggleBookmarkState>(
    'should emit [ToggleBookmarkLoading, ToggleBookmarkError] when failure',
    setUp: () {
      final sqfliteError = "sqfliteError";

      provideDummy<Either<DatabaseException, void>>(
        Left(DatabaseException.fromSQfliteError(sqfliteError)),
      );

      when(
        mockMovieUsecases.toggleBookmark(movieDetailEntity: tMovieDetailEntity),
      ).thenAnswer(
        (_) async => Left(DatabaseException.fromSQfliteError(sqfliteError)),
      );
    },
    build: () => ToggleBookmarkCubit(mockMovieUsecases),
    act:
        (ToggleBookmarkCubit cubit) =>
            cubit.toggleBookmark(movieDetailEntity: tMovieDetailEntity),
    expect:
        () => [
          const ToggleBookmarkLoading(),
          const ToggleBookmarkError(message: 'sqfliteError'),
        ],
    verify:
        (_) => verify(
          mockMovieUsecases.toggleBookmark(
            movieDetailEntity: tMovieDetailEntity,
          ),
        ).called(1),
  );
}
