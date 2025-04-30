import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'core/configs/router/app_router.dart';
import 'core/database/local_database.dart';
import 'core/network/dio_client.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/bloc/theme_cubit.dart';
import 'data/repositories/export_repository_impls.dart';
import 'data/sources/export_datasources.dart';
import 'domain/repositories/export_repositories.dart';
import 'domain/usecases/export_usecases.dart';
import 'presentation/bloc/actor/export_actor_cubits.dart';
import 'presentation/bloc/movie/export_movie_cubits.dart';

part './common/injector.dart';

final router = AppRouter();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  await init();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory:
        kIsWeb
            ? HydratedStorageDirectory.web
            : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
        BlocProvider(create: (context) => GetIt.I<GetMovieCreditsCubit>()),
        BlocProvider<GetSavedMoviesCubit>(
          create:
              (context) =>
                  injector<GetSavedMoviesCubit>()..getSavedMovieDetails(),
        ),
      ],
      child: ScreenUtilInit(
        builder: (context, child) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              return MaterialApp.router(
                themeMode: themeState.themeMode,
                title: 'Move_tmdb',
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                debugShowCheckedModeBanner: false, // 去除右上方Debug標誌
                routerDelegate: AutoRouterDelegate(router),
                routeInformationParser: router.defaultRouteParser(),
              );
            },
          );
        },
      ),
    );
  }
}
