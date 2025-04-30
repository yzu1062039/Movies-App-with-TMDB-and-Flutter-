import 'package:movie_tmdb/data/models/movie_detail/movie_detail_model.dart';

import '../../../../domain/entities/export_entities.dart';

abstract class MovieLocalDataSource {
  const MovieLocalDataSource();

  /// Saves the [movieDetailModel] to the local data source.
  Future<void> saveMovieDetail({required MovieDetailModel movieDetailModel});

  /// Deletes the movie detail with the given [movieId] from the local data source.
  Future<void> deleteMovieDetail({required int? movieId});

  /// Returns a boolean indicating whether the movie detail with the given [movieId] is saved in the local data source.
  Future<bool> isSavedMovieDetail({required int? movieId});

  /// Returns a list of all saved movie details from the local data source.
  Future<List<MovieDetailEntity>> getSavedMovieDetails();
}
