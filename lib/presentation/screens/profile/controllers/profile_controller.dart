import 'package:exodus/core/controller/base_controller.dart';
import 'package:exodus/core/routes/app_routes.dart';
import 'package:exodus/core/services/navigation_service.dart';
import 'package:exodus/core/services/secure_store_services.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/services/app_state_service.dart';

class ProfileController extends BaseController {
  final SecureStoreServices _secureStoreServices;

  ProfileController(this._secureStoreServices);

  Future<void> logout() async {
    await _secureStoreServices.deleteAllData();

    // Clear any user-specific state in other services
    sl<AppStateService>().clearUser();
    NavigationService().freshStartTo(AppRoutes.login);
  }
}
