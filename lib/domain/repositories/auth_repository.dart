import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/data/models/auth/login_response.dart';
import 'package:exodus/data/models/auth/user_response.dart';
import 'package:exodus/data/models/auth/user_data_response.dart';
import 'package:exodus/presentation/screens/auth/model/register_request.dart';

// auth_repository.dart
abstract class AuthRepository {
  Future<ApiResult<LoginResponse>> login(String email, String password);
  Future<ApiResult<User>> register(RegisterRequest params);
  Future<ApiResult<UserData>> getUserData();
  Future<ApiResult<void>> forgatePassword(String email);
  Future<ApiResult<void>> resetPassword(String email, String otp, String newPassword);
  Future<ApiResult<void>> changePassword(String email, String oldPassword, String newPassword);

}