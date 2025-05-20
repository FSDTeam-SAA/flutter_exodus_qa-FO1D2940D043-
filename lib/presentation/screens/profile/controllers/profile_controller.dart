import 'package:exodus/core/controller/base_controller.dart';
import 'package:exodus/core/routes/app_routes.dart';
import 'package:exodus/core/services/navigation_service.dart';
import 'package:exodus/core/services/secure_store_services.dart';

class ProfileController extends BaseController {
  final SecureStoreServices _secureStoreServices;

  ProfileController(this._secureStoreServices);

  Future<void> logout() async {
    await _secureStoreServices.deleteAllData();
    NavigationService().freshStartTo(AppRoutes.login);
  }
}
