import 'package:exodus/core/constants/app/key_constants.dart';
import 'package:exodus/core/controller/base_controller.dart';
import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/core/routes/app_routes.dart';
import 'package:exodus/core/services/navigation_service.dart';
import 'package:exodus/core/services/secure_store_services.dart';
import 'package:exodus/domain/usecases/auth/get_home_data.dart';
import 'package:exodus/domain/usecases/auth/login_usecase.dart';
import 'package:exodus/core/utils/debug_logger.dart';
import 'package:exodus/data/models/auth/login_response.dart';
import 'package:exodus/data/models/auth/register_response.dart';
import 'package:exodus/data/models/auth/user_data_response.dart';
import 'package:exodus/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

class LoginController extends BaseController {
  final LoginUsecase _loginUsecase;
  final GetHomeDataUsecase _getHomeDataUsecase;
  final SecureStoreServices _secureStoreServices;

  LoginController(this._loginUsecase, this._getHomeDataUsecase, this._secureStoreServices);

  final ValueNotifier<UserData?> userDataNotifier = ValueNotifier(null);

  Future<void> login(String email, String password) async {
    setLoading(true);
    clearError();

    try {
      final result = await _loginUsecase.call(email, password);
      // final result = ApiClient().post(ApiEndpoints.baseUrl + ApiEndpoints.login, fromJsonT: (json) => LoginResponse.fromJson(json));

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
        NavigationService().freshStartTo(AppRoutes.home);
        // Navigator.pushNamedAndRemoveUntil(context, newRouteName, predicate)
        dPrint("Navigation complete");
      } else {
        final message = (result as ApiError).message;
        dPrint(" Controller login message print ${message}");
      }
    } catch (e) {
      dPrint("Login error");
      throw Exception(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> getUserData() async {
    try {
      final result = await _getHomeDataUsecase.call();

      if (result is ApiSuccess<UserData>) {
        final data = result.data;
        userDataNotifier.value = result.data;
        dPrint("User Data Print -> ${data.user.email}");
      }
    } catch (e) {
      dPrint(e);
    }
  }
}
