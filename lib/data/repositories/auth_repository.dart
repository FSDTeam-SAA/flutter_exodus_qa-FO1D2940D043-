import 'package:exodus/data/models/auth_response.dart';

abstract class AuthRepository {
  Future<AuthResponse> login(String email, String password);
  Future<AuthResponse> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    String? username,
  });
  Future<void> verifyOtp(String email, String otp);
  Future<void> forgetPassword(String email);
  Future<void> resetPassword(String email, String otp, String password);
  Future<void> changePassword(String email, String oldPassword, String newPassword);
}