import 'package:exodus/core/constants/api/api_constants_endpoints.dart';
import 'package:exodus/core/network/api_client.dart';
import 'package:exodus/core/utils/debug_logger.dart';
import 'package:exodus/data/models/auth/login_response.dart';
import 'package:exodus/data/models/auth/user_response.dart';
import 'package:exodus/data/models/auth/user_data_response.dart';
import 'package:exodus/domain/repositories/auth_repository.dart';
import 'package:exodus/presentation/screens/auth/model/register_request.dart';

import '../../core/network/network_result.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _apiClient;

  AuthRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  NetworkResult<LoginResponse> login(
    String email,
    String password,
  ) {
    dPrint("email : $email");
    return _apiClient.post<LoginResponse>(
      ApiEndpoints.login,
      data: {"email": email, "password": password},
      fromJsonT: (json) => LoginResponse.fromJson(json),
    );
  }

  @override
  NetworkResult<User> register(RegisterRequest register) {
    return _apiClient.post(
      ApiEndpoints.register,
      data: {
        'name': register.name,
        'email': register.email,
        'password': register.password,
        'phone': register.phone,
      },
      fromJsonT: (json) => User.fromJson(json),
    );
  }

  @override
  NetworkResult<void> verifyOTP(String email, String otp) {
    dPrint(email);
    return _apiClient.post(
      ApiEndpoints.verifyOtp,
      data: {"email": email, "otp": otp},
      fromJsonT: (json) => {},
    );
  }

  @override
  NetworkResult<UserData> getUserData() async {
    return _apiClient.get<UserData>(
      ApiEndpoints.getUserData,
      fromJsonT: (json) => UserData.fromJson(json),
    );
  }

  @override
  NetworkResult<void> forgatePassword(String email) {
    return _apiClient.post(
      ApiEndpoints.forgetPassword,
      data: {"email": email},
      fromJsonT: (json) => {},
    );
  }

  @override
  NetworkResult<void> resetPassword(
    String email,
    String otp,
    String newPassword,
  ) {
    return _apiClient.post(
      ApiEndpoints.resetPassword,
      data: {"email": email, "otp": otp, "newPassword": newPassword},
      fromJsonT: (json) => {},
    );
  }

  @override
  NetworkResult<void> changePassword(
    String email,
    String oldPassword,
    String newPassword,
  ) {
    return _apiClient.post(
      ApiEndpoints.changePassword,
      data: {
        "email": email,
        "oldPassword": oldPassword,
        "newPassword": newPassword,
      },

      fromJsonT: (json) => {},
    );
  }
}
