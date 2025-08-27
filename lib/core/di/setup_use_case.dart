import 'package:exodus/core/di/service_locator.dart';
import 'package:exodus/domain/usecases/auth/change_password_usecases.dart';
import 'package:exodus/domain/usecases/auth/check_auth_status_usecase.dart';
import 'package:exodus/domain/usecases/auth/forgate_password_usecases.dart';
import 'package:exodus/domain/usecases/auth/register_usecase.dart';
import 'package:exodus/domain/usecases/auth/reset_password_usecases.dart';
import 'package:exodus/domain/usecases/auth/verify_otp_usecase.dart';
import 'package:exodus/domain/usecases/bookARide/cancel_ticket_usecase.dart';
import 'package:exodus/domain/usecases/bookARide/create_ticket_usecase.dart';
import 'package:exodus/domain/usecases/bookARide/get_single_bus_data_usecase.dart';
import 'package:exodus/domain/usecases/bookARide/list_of_available_suttles_usecase.dart';
import 'package:exodus/domain/usecases/bookARide/list_of_routes_usecase.dart';
import 'package:exodus/domain/usecases/home/get_home_data.dart';
import 'package:exodus/domain/usecases/auth/login_usecase.dart';
import 'package:exodus/domain/usecases/home/notification_data_usecase.dart';
import 'package:exodus/domain/usecases/userProfile/ride_history_usecase.dart';

import '../../domain/usecases/userProfile/user_profile_update_usecase.dart';

void setupUseCase() {
  sl.registerLazySingleton(() => CheckAuthStatusUsecase(sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => RegisterUsecase(sl()));
  sl.registerLazySingleton(() => VerfifyResetOTPUseCase(sl()));
  sl.registerLazySingleton(() => GetHomeDataUsecase(sl()));
  sl.registerLazySingleton(() => NotificationDataUsecase(sl()));

  // Password Usecases
  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));
  sl.registerLazySingleton(() => ChangePasswordUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));

  // Profile Usecases
  sl.registerLazySingleton(() => RideHistoryUsecase(sl()));
  sl.registerLazySingleton(() => UserProfileUpdateUsecase(sl()));

  // Book A Ride Usecases
  sl.registerLazySingleton(() => ListOfRoutesUsecase(sl()));
  sl.registerLazySingleton(() => GetAvailableShuttlesUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetSingleBusDataUsecase(sl()));
  sl.registerLazySingleton(() => CreateTicketUsecase(sl()));
  sl.registerLazySingleton(() => CancelTicketUsecase(sl()));
}
