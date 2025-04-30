part of '../main.dart';

final injector = GetIt.instance;
Future<void> init() async {
  injector
    //* Network
    ..registerLazySingleton<DioClient>(DioClient.new)
    //* Database
    ..registerLazySingleton<LocalDatabase>(() => LocalDatabase.instance)
    //* Data Sources
    ..registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(injector()),
    )
    ..registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(),
    )
    ..registerLazySingleton<ActorRemoteDataSource>(
      () => ActorRemoteDataSourceImpl(injector()),
    )
    //* Repositories
    ..registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(injector(), injector()),
    )
    ..registerLazySingleton<ActorRepository>(
      () => ActorRepositoryImpl(injector()),
    )
    //* Usecases
    ..registerLazySingleton<MovieUsecases>(() => MovieUsecases(injector()))
    ..registerLazySingleton<ActorUsecases>(() => ActorUsecases(injector()))
    //* Cubits
    ..registerLazySingleton<GetTopRatedMoviesCubit>(
      () => GetTopRatedMoviesCubit(injector()),
    )
    ..registerFactory<GetMovieCreditsCubit>(
      () => GetMovieCreditsCubit(injector()),
    )
    ..registerLazySingleton<GetPopularMoviesCubit>(
      () => GetPopularMoviesCubit(injector()),
    )
    ..registerLazySingleton<GetActorDetailCubit>(
      () => GetActorDetailCubit(injector()),
    )
    ..registerLazySingleton<GetSavedMoviesCubit>(
      () => GetSavedMoviesCubit(injector()),
    )
    ..registerFactory<ToggleBookmarkCubit>(
      () => ToggleBookmarkCubit(injector()),
    )
    ..registerFactory<GetActorSocialMediaCubit>(
      () => GetActorSocialMediaCubit(injector()),
    );
}
