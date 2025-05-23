import 'package:exodus/core/di/service_locator.dart';
import 'package:exodus/core/services/app_state_service.dart';
import 'package:exodus/core/services/secure_store_services.dart';
import 'package:exodus/domain/usecases/home/get_home_data.dart';
import 'package:exodus/domain/usecases/auth/login_usecase.dart';
import 'package:exodus/domain/usecases/home/notification_data_usecase.dart';
import 'package:exodus/domain/usecases/userProfile/ride_history_usecase.dart';
import 'package:exodus/presentation/screens/auth/controllers/login_controller.dart';
import 'package:exodus/presentation/screens/home/controller/home_controller.dart';
import 'package:exodus/presentation/screens/notification/controllers/notification_controller.dart';
import 'package:exodus/presentation/screens/profile/controllers/profile_controller.dart';
import 'package:exodus/presentation/screens/profile/controllers/ride_history_controller.dart';

import '../services/socket_services.dart';

void setupController() {
  sl.registerFactory(
    () => LoginController(sl<LoginUsecase>(), sl<SecureStoreServices>(), sl<SocketService>()),
  );

  sl.registerFactory(
    () => HomeController(sl<AppStateService>(), sl<GetHomeDataUsecase>()),
  );

  sl.registerFactory(() => ProfileController(sl<SecureStoreServices>()));

  sl.registerFactory(() => NotificationController(sl<NotificationDataUsecase>(), sl<SocketService>()));

  sl.registerFactory(() => RideHistoryController(sl<RideHistoryUsecase>()));
  
}
