import 'package:exodus/core/di/service_locator.dart';
import 'package:exodus/core/services/secure_store_services.dart';
import 'package:exodus/domain/usecases/auth/get_home_data.dart';
import 'package:exodus/domain/usecases/auth/login_usecase.dart';
import 'package:exodus/presentation/screens/auth/controllers/login_controller.dart';

void setupController() {
  sl.registerFactory(
    () => LoginController(sl<LoginUsecase>(), sl<GetHomeDataUsecase>(), sl<SecureStoreServices>()),
  );
}
