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

  late final MovieDetailEntity tMovieDetailEntity1;
  late final MovieDetailEntity tMovieDetailEntity2;
  late final MovieDetailEntity tMovieDetailEntity3;
  late final MovieDetailEntity tMovieDetailEntity4;

  setUpAll(() {
    mockMovieUsecases = MockMovieUsecases();

    tMovieDetailEntity1 = const MovieDetailEntity(
      id: 1,
      title: 'title',
      overview: 'overview',
      posterPath: 'posterPath',
      backdropPath: 'backdropPath',
    );

    tMovieDetailEntity2 = const MovieDetailEntity(
      id: 2,
      title: 'title',
      overview: 'overview',
      posterPath: 'posterPath',
      backdropPath: 'backdropPath',
    );

    tMovieDetailEntity3 = const MovieDetailEntity(
      id: 3,
      title: 'title',
      overview: 'overview',
      posterPath: 'posterPath',
      backdropPath: 'backdropPath',
    );

    tMovieDetailEntity4 = const MovieDetailEntity(
      id: 4,
      title: 'title',
      overview: 'overview',
      posterPath: 'posterPath',
      backdropPath: 'backdropPath',
    );
  });

  blocTest<GetSavedMoviesCubit, GetSavedMoviesState>(
    'should emit [GetSavedMoviesLoading, GetSavedMoviesLoaded] when success',
    setUp: () {
      final tMovieList = [
        tMovieDetailEntity1,
        tMovieDetailEntity2,
        tMovieDetailEntity3,
        tMovieDetailEntity4,
      ];

      provideDummy<Either<DatabaseException, List<MovieDetailEntity>>>(
        Right(tMovieList),
      );

      when(
        mockMovieUsecases.getSavedMovieDetails(),
      ).thenAnswer((_) async => Right(tMovieList));
    },
    build: () => GetSavedMoviesCubit(mockMovieUsecases),
    act: (bloc) => bloc.getSavedMovieDetails(),
    expect:
        () => [
          const GetSavedMoviesLoading(),
          GetSavedMoviesLoaded(
            movies: [
              tMovieDetailEntity1,
              tMovieDetailEntity2,
              tMovieDetailEntity3,
              tMovieDetailEntity4,
            ],
          ),
        ],
    verify: (_) => verify(mockMovieUsecases.getSavedMovieDetails()).called(1),
  );

  blocTest<GetSavedMoviesCubit, GetSavedMoviesState>(
    'should emit [GetSavedMoviesLoading, GetSavedMoviesError] when failure',
    setUp: () {
      final sqfliteError = "sqfliteError";

      provideDummy<Either<DatabaseException, List<MovieDetailEntity>>>(
        Left(DatabaseException.fromSQfliteError(sqfliteError)),
      );

      when(mockMovieUsecases.getSavedMovieDetails()).thenAnswer(
        (_) async => Left(DatabaseException.fromSQfliteError(sqfliteError)),
      );
    },
    build: () => GetSavedMoviesCubit(mockMovieUsecases),
    act: (bloc) => bloc.getSavedMovieDetails(),
    expect:
        () => [
          const GetSavedMoviesLoading(),
          const GetSavedMoviesError(message: 'sqfliteError'),
        ],
    verify: (_) => verify(mockMovieUsecases.getSavedMovieDetails()).called(1),
  );
}
