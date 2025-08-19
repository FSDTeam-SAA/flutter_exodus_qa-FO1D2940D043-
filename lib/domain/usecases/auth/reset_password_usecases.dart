import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/domain/repositories/auth_repository.dart';

import '../../../core/network/network_result.dart';

class ResetPasswordUseCase {
  final AuthRepository _repository;

  ResetPasswordUseCase(this._repository);

  NetworkResult<void> call(String email, String otp, String newPassword) {
    return _repository.resetPassword(email, otp, newPassword);
  }
}
