import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:movie_tmdb/data/models/movie_detail/movie_detail_model.dart';

import '../../../core/exceptions/database/database_exception.dart';
import '../../../core/exceptions/network/network_exception.dart';
import '../../../domain/entities/export_entities.dart';
import '../../../domain/repositories/movie/movie_repository.dart';
import '../../sources/export_datasources.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource _movieRemoteDataSource;
  final MovieLocalDataSource _movieLocalDataSource;

  MovieRepositoryImpl(this._movieRemoteDataSource, this._movieLocalDataSource);

  //* REMOTE
  @override
  Future<Either<NetworkException, MovieListingsEntity>> getPopularMovies({
    required int page,
  }) async {
    try {
      final result = await _movieRemoteDataSource.getPopularMovies(page: page);

      return Right(result.toEntity());
    } on DioException catch (e) {
      return Left(NetworkException.fromDioError(e));
    }
  }

  @override
  Future<Either<NetworkException, MovieListingsEntity>> getTopRatedMovies({
    required int page,
  }) async {
    try {
      final result = await _movieRemoteDataSource.getTopRatedMovies(page: page);

      return Right(result.toEntity());
    } on DioException catch (e) {
      return Left(NetworkException.fromDioError(e));
    }
  }

  @override
  Future<Either<NetworkException, MovieCreditEntity>> getMovieCredits({
    required int movieId,
  }) async {
    try {
      final result = await _movieRemoteDataSource.getMovieCredits(
        movieId: movieId,
      );

      return Right(result.toEntity());
    } on DioException catch (e) {
      return Left(NetworkException.fromDioError(e));
    }
  }

  //* LOCAL
  @override
  Future<Either<DatabaseException, List<MovieDetailEntity>>>
  getSavedMovieDetails() async {
    try {
      final result = await _movieLocalDataSource.getSavedMovieDetails();

      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseException.fromSQfliteError(e));
    }
  }

  @override
  Future<Either<DatabaseException, void>> saveMovieDetails({
    required MovieDetailEntity? movieDetailEntity,
  }) async {
    try {
      final result = await _movieLocalDataSource.saveMovieDetail(
        movieDetailModel: MovieDetailModel().fromEntity(movieDetailEntity),
      );

      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseException.fromSQfliteError(e));
    }
  }

  @override
  Future<Either<DatabaseException, void>> deleteMovieDetail({
    required int? movieId,
  }) async {
    try {
      final result = await _movieLocalDataSource.deleteMovieDetail(
        movieId: movieId,
      );

      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseException.fromSQfliteError(e));
    }
  }

  @override
  Future<Either<DatabaseException, bool>> isSavedMovieDetail({
    required int? movieId,
  }) async {
    try {
      final result = await _movieLocalDataSource.isSavedMovieDetail(
        movieId: movieId,
      );

      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseException.fromSQfliteError(e));
    }
  }
}
