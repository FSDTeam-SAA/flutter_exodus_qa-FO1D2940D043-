import 'package:exodus/core/di/service_locator.dart';
import 'package:exodus/data/repositories/auth_repository_impl.dart';
import 'package:exodus/domain/repositories/auth_repository.dart';

void setupRepository() {
  sl.registerCachedFactory<AuthRepository>(
    () => AuthRepositoryImpl(apiClient: sl()),
  );
}
