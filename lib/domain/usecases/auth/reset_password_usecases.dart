import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/domain/repositories/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository _repository;

  ResetPasswordUseCase(this._repository);

  Future<ApiResult<void>> execute(
    String email,
    String otp,
    String newPassword,
  ) {
    return _repository.resetPassword(email, otp, newPassword);
  }
}
