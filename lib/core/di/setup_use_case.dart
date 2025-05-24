import 'package:exodus/core/di/service_locator.dart';
import 'package:exodus/domain/usecases/auth/check_auth_status_usecase.dart';
import 'package:exodus/domain/usecases/bookARide/list_of_available_suttles_usecase.dart';
import 'package:exodus/domain/usecases/bookARide/list_of_routes_usecase.dart';
import 'package:exodus/domain/usecases/home/get_home_data.dart';
import 'package:exodus/domain/usecases/auth/login_usecase.dart';
import 'package:exodus/domain/usecases/home/notification_data_usecase.dart';
import 'package:exodus/domain/usecases/userProfile/ride_history_usecase.dart';

void setupUseCase() {
  sl.registerLazySingleton(() => CheckAuthStatusUsecase(sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => GetHomeDataUsecase(sl()));
  sl.registerLazySingleton(() => NotificationDataUsecase(sl()));

  // Profile Usecases
  sl.registerLazySingleton(() => RideHistoryUsecase(sl()));

  // Book A Ride Usecases
  sl.registerLazySingleton(() => ListOfRoutesUsecase(sl()));
  sl.registerLazySingleton(() => GetAvailableShuttlesUseCase(repository: sl()));
}
