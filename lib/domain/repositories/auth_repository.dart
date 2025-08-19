import 'package:exodus/data/models/auth/login_response.dart';
import 'package:exodus/data/models/auth/user_response.dart';
import 'package:exodus/data/models/auth/user_data_response.dart';
import 'package:exodus/presentation/screens/auth/model/register_request.dart';

import '../../core/network/network_result.dart';

// auth_repository.dart
abstract class AuthRepository {
  NetworkResult<LoginResponse> login(String email, String password);
  NetworkResult<UserData> getUserData();
  NetworkResult<User> register(RegisterRequest params);
  NetworkResult<void> verifyOTP(String email, String otp);
  NetworkResult<void> forgatePassword(String email);
  NetworkResult<void> resetPassword(String email, String otp, String newPassword);
  NetworkResult<void> changePassword(String email, String oldPassword, String newPassword);

}