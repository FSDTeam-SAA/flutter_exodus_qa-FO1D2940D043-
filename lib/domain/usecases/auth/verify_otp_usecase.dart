import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/domain/repositories/auth_repository.dart';

class VerfifyOTPUseCase {
  final AuthRepository _repository;

  VerfifyOTPUseCase(this._repository);

  Future<ApiResult<void>> call(String email, String otp) {
    return _repository.verifyOTP(email, otp);
  }
}
