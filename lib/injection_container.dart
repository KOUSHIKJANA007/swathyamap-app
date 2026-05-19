import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:swasthyamap/core/config/routes/app_routes.dart';
import 'package:swasthyamap/core/services/auth_service/auth_session_service.dart';
import 'package:swasthyamap/core/services/auth_service/local_auth_storage_service.dart';

final sl = GetIt.instance;

Future<void> initDependency() async {
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(()=>LocalAuthStorageService(sl()));
  sl.registerLazySingleton<AuthSessionService>(()=>AuthSessionServiceImpl(sl()));
  sl.registerLazySingleton(()=>AppRoutes(authSessionService: sl()));
}