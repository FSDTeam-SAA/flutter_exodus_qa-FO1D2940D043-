import 'package:exodus/core/di/service_locator.dart';
import 'package:exodus/core/network/api_client.dart';
import 'package:exodus/core/services/navigation_service.dart';
import 'package:exodus/core/services/secure_store_services.dart';

void setupCore() {
  sl.registerLazySingleton(() => ApiClient());
  sl.registerLazySingleton(() => NavigationService());
  sl.registerFactory(() => SecureStoreServices());
}