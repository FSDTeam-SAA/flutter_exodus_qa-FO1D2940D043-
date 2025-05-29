import 'dart:io';

import 'package:exodus/core/constants/app/key_constants.dart';
import 'package:exodus/core/controller/base_controller.dart';
import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/core/routes/app_routes.dart';
import 'package:exodus/core/services/navigation_service.dart';
import 'package:exodus/core/services/secure_store_services.dart';
import 'package:exodus/core/services/socket_services.dart';
import 'package:exodus/domain/usecases/auth/login_usecase.dart';
import 'package:exodus/core/utils/debug_logger.dart';
import 'package:exodus/data/models/auth/login_response.dart';

class LoginController extends BaseController {
  final LoginUsecase _loginUsecase;
  final SecureStoreServices _secureStoreServices;


  LoginController(
    this._loginUsecase,
    this._secureStoreServices,

  );

  Future<void> login(String email, String password) async {
    setLoading(true);
    clearError();

    try {
      final result = await _loginUsecase.call(email, password);

      if (result is ApiSuccess<LoginResponse>) {
        dPrint("Success}");
        final data = result.data;

        await _secureStoreServices.storeData(
          KeyConstants.accessToken,
          data.accessToken,
        );
        await _secureStoreServices.storeData(
          KeyConstants.refreshToken,
          data.refreshToken,
        );
        await _secureStoreServices.storeData(KeyConstants.role, data.role);

        if (data.isUser) {
          NavigationService().freshStartTo(AppRoutes.bottomNavbar);
        }
        // if (data.isDriver) {
        //   NavigationService().freshStartTo(AppRoutes.driverHome);
        // }

        dPrint("User role: ${data.role}");
        // Navigator.pushNamedAndRemoveUntil(context, newRouteName, predicate)
        dPrint("Navigation complete");
      } else {
        final message = (result as ApiError).message;
        // check if OTP is not verified
        if (message.toLowerCase().contains("otp is not verified")) {
          NavigationService().sailTo(
            AppRoutes.codeVerify,
            arguments: {'email': email, 'fromLogin': true},
          );
          return;
        }
        setError(message);
        dPrint(" Controller login message print $message");
        notifyListeners();
      }
    } catch (e) {
      dPrint("Login error");
      throw Exception(e.toString());
    } finally {
      setLoading(false);
    }
  }
}
