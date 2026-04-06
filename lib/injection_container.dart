import 'package:game_seeker/features/gaming/infrastructure/datasources/gaming_repository_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'features/gaming/domain/repositories/i_gaming_repository.dart';
import 'features/gaming/domain/usecases/get_games.dart';
import 'features/gaming/domain/usecases/get_genres.dart';
import 'features/gaming/infrastructure/datasources/gaming_remote_data_source.dart';
import 'features/gaming/application/category_bloc/category_bloc.dart';
import 'features/gaming/application/category_games_bloc/category_games_bloc.dart';
import 'features/gaming/application/all_games_bloc/all_games_bloc.dart';

final sl = GetIt.instance; // sl stands for Service Locator

Future<void> init() async {
  //! Features - Gaming

  // BLoCs (Factory: always creates a new instance when asked)
  sl.registerFactory(() => CategoryBloc(getGenres: sl()));
  sl.registerFactory(() => CategoryGamesBloc(getGames: sl()));
  sl.registerFactory(() => AllGamesBloc(getGames: sl()));

  // Use cases (LazySingleton: creates it only when first needed)
  sl.registerLazySingleton(() => GetGenres(sl()));
  sl.registerLazySingleton(() => GetGames(sl()));

  // Repository
  sl.registerLazySingleton<IGamingRepository>(
    () => GamingRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<IGamingRemoteDataSource>(
    () => GamingRemoteDataSourceImpl(
      client: sl(),
      apiKey: dotenv.env['RAWG_API_KEY'] ?? '',
      baseUrl: dotenv.env['RAWG_BASE_URL'] ?? '',
    ),
  );

  //! Core
  // No core utilities for now, but this is where NetworkInfo would go.

  //! External
  sl.registerLazySingleton(() => Dio());
}
