import 'package:exodus/core/di/setup_controller.dart';
import 'package:exodus/core/di/setup_core.dart';
import 'package:exodus/core/di/setup_repository.dart';
import 'package:exodus/core/di/setup_use_case.dart';
import 'package:get_it/get_it.dart';


import '../network/interceptor/custom_cache_interceptor.dart';

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



  // Core Service
  setupCore();

  // Usecase
  setupUseCase();

  // Repositories
  setupRepository();

  // Controllers
  setupController();
}
