import 'package:exodus/core/di/service_locator.dart';
import 'package:exodus/core/services/app_state_service.dart';
import 'package:exodus/core/services/secure_store_services.dart';
import 'package:exodus/domain/usecases/home/get_home_data.dart';
import 'package:exodus/domain/usecases/auth/login_usecase.dart';
import 'package:exodus/presentation/screens/auth/controllers/login_controller.dart';
import 'package:exodus/presentation/screens/home/controller/home_controller.dart';
import 'package:exodus/presentation/screens/profile/controllers/profile_controller.dart';

void setupController() {
  sl.registerFactory(
    () => LoginController(sl<LoginUsecase>(), sl<SecureStoreServices>()),
  );

  sl.registerFactory(
    () => HomeController(sl<AppStateService>(), sl<GetHomeDataUsecase>()),
  );

  sl.registerFactory(() => ProfileController(sl<SecureStoreServices>()));
}
