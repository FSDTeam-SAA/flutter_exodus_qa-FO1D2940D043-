import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/data/models/auth_response.dart';
import 'package:exodus/data/models/user_models.dart';

abstract class AuthRepository {
  Future<ApiResult<User>> login(String email, String password);
  // Future<AuthResponse> register({
  //   required String name,
  //   required String email,
  //   required String password,
  //   required String phone,
  // });
  // Future<void> verifyOtp(String email, String otp);
  // Future<void> forgetPassword(String email);
  // Future<void> resetPassword(String email, String otp, String password);
  // Future<void> changePassword(String email, String oldPassword, String newPassword);
}
