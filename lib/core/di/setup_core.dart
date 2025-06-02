import 'package:exodus/core/di/service_locator.dart';
import 'package:exodus/core/network/api_client.dart';
import 'package:exodus/core/services/navigation_service.dart';
import 'package:exodus/core/services/secure_store_services.dart';
import 'package:exodus/presentation/core/services/app_data_store.dart';

// import '../network/interceptor/token_refresh_interceptor.dart';
import '../services/app_state_service.dart';

void setupCore() {
  sl.registerLazySingleton(() => ApiClient());
  sl.registerLazySingleton(() => NavigationService());
  sl.registerFactory(() => SecureStoreServices());

  // sl.registerLazySingleton(
  //   () => TokenRefreshInterceptor(sl<ApiClient>(), sl<SecureStoreServices>()),
  // );

  /// [Global User Data Store]
  sl.registerLazySingleton(() => AppStateService());
  sl.registerLazySingleton<AppDataStore>(() => AppDataStore());
}
