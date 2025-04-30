import 'package:movie_tmdb/data/models/movie_detail/movie_detail_model.dart';

import '../../../../core/database/local_database.dart';
import '../../../../domain/entities/export_entities.dart';
import 'movie_local_data_source.dart';

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  MovieLocalDataSourceImpl();

  final LocalDatabase localDatabase = LocalDatabase.instance;

  /// Deletes the movie detail with the given [movieId] from the local database.
  @override
  Future<void> deleteMovieDetail({required int? movieId}) async {
    try {
      localDatabase.deleteMovieDetail(movieId: movieId);
    } catch (_) {
      rethrow;
    }
  }

  /// Retrieves all saved movie details from the local database.
  @override
  Future<List<MovieDetailEntity>> getSavedMovieDetails() async {
    try {
      return localDatabase.getSavedMovieDetails();
    } catch (_) {
      rethrow;
    }
  }

  /// Saves the given [movieDetailModel] to the local database.
  @override
  Future<void> saveMovieDetail({
    required MovieDetailModel movieDetailModel,
  }) async {
    try {
      localDatabase.saveMovieDetail(movieDetailModel: movieDetailModel);
    } catch (_) {
      rethrow;
    }
  }

  /// Checks if the movie detail with the given [movieId] is saved in the local database.
  @override
  Future<bool> isSavedMovieDetail({required int? movieId}) async {
    try {
      return localDatabase.isSavedMovieDetail(movieId: movieId);
    } catch (_) {
      rethrow;
    }
  }
}
