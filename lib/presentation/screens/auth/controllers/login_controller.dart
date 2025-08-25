import 'package:exodus/core/constants/app/key_constants.dart';
import 'package:exodus/core/controller/base_controller.dart';
import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/core/network/extensions/either_extensions.dart';
import 'package:exodus/core/routes/app_routes.dart';
import 'package:exodus/core/services/navigation_service.dart';
import 'package:exodus/core/services/secure_store_services.dart';
import 'package:exodus/domain/usecases/auth/login_usecase.dart';
import 'package:exodus/core/utils/debug_logger.dart';
import 'package:exodus/data/models/auth/login_response.dart';

import '../../../../core/network/services/auth_storage_service.dart';

class LoginController extends BaseController {
  final LoginUsecase _loginUsecase;
  final SecureStoreServices _secureStoreServices;
  final AuthStorageService _authStorageService;

  LoginController(
    this._loginUsecase,
    this._authStorageService,
    this._secureStoreServices,
  );

  Future<void> login(String email, String password) async {
    setLoading(true);
    clearError();

    try {
      final result = await _loginUsecase.call(email, password);

      result.handle(
        onSuccess: (data) async {
          dPrint("Success}");
          // final data = result.data;

          _authStorageService.storeAccessToken(data.data.accessToken);
          _authStorageService.storeRefreshToken(data.data.refreshToken);

          // await _secureStoreServices.storeData(
          //   KeyConstants.accessToken,
          //   data.accessToken,
          // );
          // await _secureStoreServices.storeData(
          //   KeyConstants.refreshToken,
          //   data.refreshToken,
          // );
          await _secureStoreServices.storeData(KeyConstants.email, email);
          await _secureStoreServices.storeData(KeyConstants.role, data.data.role);
          if (data.data.isUser) {
            NavigationService().freshStartTo(AppRoutes.bottomNavbar);
          }
          // if (data.isDriver) {
          //   NavigationService().freshStartTo(AppRoutes.driverHome);
          // }

          dPrint("User role: ${data.data.role}");
          // Navigator.pushNamedAndRemoveUntil(context, newRouteName, predicate)
          dPrint("Navigation complete");
        },
        onFailure: (e) {
          if (e.message.toLowerCase().contains("otp is not verified")) {
            NavigationService().sailTo(
              AppRoutes.codeVerify,
              arguments: {'email': email, 'fromLogin': true},
            );
            return;
          }
          setError(e.message);
          dPrint(" Controller login message print ${e.message}");
          notifyListeners();
        },
      );
    } catch (e) {
      dPrint("Login error");
      throw Exception(e.toString());
    } finally {
      setLoading(false);
    }
  }
}
