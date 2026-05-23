import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:swasthyamap/core/config/routes/app_routes.dart';
import 'package:swasthyamap/core/network/dio_client.dart';
import 'package:swasthyamap/core/network/dio_logging_interceptor.dart';
import 'package:swasthyamap/core/network/dio_token_refresh_interceptor.dart';
import 'package:swasthyamap/core/services/auth_service/auth_session_service.dart';
import 'package:swasthyamap/core/services/auth_service/local_auth_storage_service.dart';
import 'package:swasthyamap/feature/auth/data/datasource/auth_remote_datasource.dart';
import 'package:swasthyamap/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:swasthyamap/feature/auth/domain/repository/auth_repository.dart';
import 'package:swasthyamap/feature/auth/domain/usecases/do_login_use_case.dart';
import 'package:swasthyamap/feature/auth/domain/usecases/find_logged_in_user_use_case.dart';
import 'package:swasthyamap/feature/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependency() async {
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => LocalAuthStorageService(sl()));
  sl.registerLazySingleton<AuthSessionService>(
    () => AuthSessionServiceImpl(sl()),
  );
  sl.registerLazySingleton(() => AppRoutes(authSessionService: sl()));

  //Dio
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => DioLoggingInterceptor());
  sl.registerLazySingleton(() => DioTokenRefreshInterceptor(authSessionService: sl(), dio: sl()));
  sl.registerLazySingleton(
    () => DioClient(
      dio: sl(),
      authSessionService: sl(),
      dioLoggingInterceptor: sl(),
      dioTokenRefreshInterceptor: sl(),
    ),
  );

  //Auth
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(sl()),
  );
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton(() => DoLoginUseCase(sl()));
  sl.registerLazySingleton(() => FindLoggedInUserUseCase(sl()));
  sl.registerLazySingleton(
    () => AuthBloc(
      doLoginUseCase: sl(),
      findLoggedInUserUseCase: sl(),
      authSessionService: sl(),
    ),
  );
}
