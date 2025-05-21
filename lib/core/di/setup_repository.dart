import 'package:exodus/core/di/service_locator.dart';
import 'package:exodus/data/repositories/auth_repository_impl.dart';
import 'package:exodus/data/repositories/notification_repository_impl.dart';
import 'package:exodus/domain/repositories/auth_repository.dart';
import 'package:exodus/domain/repositories/notification_repository.dart';

void setupRepository() {
  sl.registerCachedFactory<AuthRepository>(
    () => AuthRepositoryImpl(apiClient: sl()),
  );

  sl.registerCachedFactory<NotificationRepository>(() => NotificationRepositoryImpl(apiClient: sl()));
}
