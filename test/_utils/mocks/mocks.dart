import 'package:mockito/annotations.dart';
import 'package:movie_tmdb/core/network/dio_client.dart';
import 'package:movie_tmdb/data/sources/export_datasources.dart';
import 'package:movie_tmdb/domain/repositories/export_repositories.dart';
import 'package:movie_tmdb/domain/usecases/export_usecases.dart';

@GenerateMocks([
  DioClient,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  ActorRemoteDataSource,
  MovieRepository,
  ActorRepository,
  MovieUsecases,
  ActorUsecases,
])
void main() {}
