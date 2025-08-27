import 'package:exodus/domain/repositories/auth_repository.dart';

import '../../../core/network/network_result.dart';

class VerfifyOTPUseCase {
  final AuthRepository _repository;

  VerfifyOTPUseCase(this._repository);

  NetworkResult<void> call(String email, String otp) {
    return _repository.verifyResetOTP(email, otp);
  }
}
