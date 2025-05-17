import 'package:exodus/core/di/service_locator.dart';
import 'package:exodus/domain/usecases/auth/check_auth_status_usecase.dart';
import 'package:exodus/domain/usecases/auth/get_home_data.dart';
import 'package:exodus/domain/usecases/auth/login_usecase.dart';

void setupUseCase() {
  sl.registerLazySingleton(() => CheckAuthStatusUsecase(sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => GetHomeDataUsecase(sl()));
}
