import 'package:exodus/core/network/api_client.dart';
import 'package:exodus/core/services/secure_store_services.dart';
import 'package:exodus/data/repositories/auth_repository_impl.dart';
import 'package:exodus/domain/repositories/auth_repository.dart';
import 'package:exodus/presentation/screens/auth/controllers/login_controller.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  // Core Service
  sl.registerLazySingleton(() => ApiClient());
  sl.registerFactory(() => SecureStoreServices());

  // Repositories
  sl.registerCachedFactory<AuthRepository>(() => AuthRepositoryImpl(apiClient: sl()));

  // Controllers
  sl.registerFactory(() => LoginController(sl<AuthRepository>()));

}