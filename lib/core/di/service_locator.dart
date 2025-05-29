import 'package:exodus/core/di/setup_controller.dart';
import 'package:exodus/core/di/setup_core.dart';
import 'package:exodus/core/di/setup_repository.dart';
import 'package:exodus/core/di/setup_use_case.dart';
import 'package:get_it/get_it.dart';

import '../network/interceptor/custom_cache_interceptor.dart';
import '../services/location_service.dart';
import '../services/socket_service.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  // Register cache interceptor
  sl.registerLazySingleton(
    () => CustomCacheInterceptor(
      maxCacheAge: const Duration(
        minutes: 30,
      ), // Adjust cache duration as needed
    ),
  );

  sl.registerSingleton<SocketService>(SocketService());
  sl.registerSingleton<LocationService>(LocationService());

  // Core Service
  setupCore();

  // Usecase
  setupUseCase();

  // Repositories
  setupRepository();

  // Controllers
  setupController();
}
