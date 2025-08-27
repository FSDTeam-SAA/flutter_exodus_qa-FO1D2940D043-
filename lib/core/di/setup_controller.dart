import 'package:exodus/core/di/service_locator.dart';
import 'package:exodus/core/network/services/auth_storage_service.dart';
import 'package:exodus/core/services/app_state_service.dart';
import 'package:exodus/core/services/secure_store_services.dart';
import 'package:exodus/domain/usecases/auth/change_password_usecases.dart';
import 'package:exodus/domain/usecases/auth/forgate_password_usecases.dart';
import 'package:exodus/domain/usecases/auth/register_usecase.dart';
import 'package:exodus/domain/usecases/auth/reset_password_usecases.dart';
import 'package:exodus/domain/usecases/auth/verify_otp_usecase.dart';
import 'package:exodus/domain/usecases/bookARide/get_single_bus_data_usecase.dart';
import 'package:exodus/domain/usecases/bookARide/list_of_available_suttles_usecase.dart';
import 'package:exodus/domain/usecases/bookARide/list_of_routes_usecase.dart';
import 'package:exodus/domain/usecases/home/get_home_data.dart';
import 'package:exodus/domain/usecases/auth/login_usecase.dart';
import 'package:exodus/domain/usecases/home/notification_data_usecase.dart';
import 'package:exodus/domain/usecases/userProfile/ride_history_usecase.dart';
import 'package:exodus/domain/usecases/userProfile/user_profile_update_usecase.dart';
import 'package:exodus/presentation/screens/auth/controllers/login_controller.dart';
import 'package:exodus/presentation/screens/auth/controllers/password_reset_controller.dart';
import 'package:exodus/presentation/screens/auth/controllers/register_controller.dart';
import 'package:exodus/presentation/screens/auth/controllers/verify_code_controller.dart';
import 'package:exodus/presentation/screens/book_a_ride/controllers/create_ticket_controller.dart';
import 'package:exodus/presentation/screens/book_a_ride/controllers/list_of_routs.dart';
import 'package:exodus/presentation/screens/book_a_ride/controllers/payment_controller.dart';
import 'package:exodus/presentation/screens/home/controller/home_controller.dart';
import 'package:exodus/presentation/screens/notification/controllers/notification_controller.dart';
import 'package:exodus/presentation/screens/profile/controllers/profile_controller.dart';
import 'package:exodus/presentation/screens/profile/controllers/ride_history_controller.dart';

void setupController() {
  sl.registerFactory(
    () => LoginController(
      sl<LoginUsecase>(),
      sl<AuthStorageService>(),
      sl<SecureStoreServices>(),
    ),
  );

  sl.registerFactory(() => RegisterController(sl<RegisterUsecase>()));
  sl.registerFactory(
    () => VerifyCodeController(
      sl<VerfifyResetOTPUseCase>(),
      sl<VerfifyResetOTPUseCase>(),
    ),
  );

  // Password Controllers
  sl.registerFactory(
    () => PasswordResetController(
      forgotPasswordUseCase: sl<ForgotPasswordUseCase>(),
      resetPasswordUseCase: sl<ResetPasswordUseCase>(),
      changePasswordUseCase: sl<ChangePasswordUseCase>(),
    ),
  );

  sl.registerFactory(
    () => HomeController(sl<AppStateService>(), sl<GetHomeDataUsecase>()),
  );

  sl.registerFactory(
    () => ProfileController(
      sl<AuthStorageService>(),
      sl<UserProfileUpdateUsecase>(),
      sl<GetHomeDataUsecase>(),
      sl<AppStateService>(),
    ),
  );

  sl.registerFactory(
    () => NotificationController(sl<NotificationDataUsecase>()),
  );

  sl.registerFactory(() => RideHistoryController(sl<RideHistoryUsecase>()));

  // Book A Ride Controllers
  // sl.registerFactory(() => BookARideController(sl<ListOfRoutesUsecase>()));
  sl.registerFactory(
    () => ListOfRoutsController(
      sl<ListOfRoutesUsecase>(),
      sl<GetAvailableShuttlesUseCase>(),
      sl<GetSingleBusDataUsecase>(),
    ),
  );

  sl.registerFactory(() => CreateTicketController(sl(), sl()));

  sl.registerFactory(() => PaymentController(sl()));
}
