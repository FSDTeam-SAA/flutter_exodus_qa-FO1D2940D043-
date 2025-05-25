import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/domain/repositories/auth_repository.dart';

class ForgotPasswordUseCase {
  final AuthRepository _repository;

  ForgotPasswordUseCase(this._repository);

  Future<ApiResult<void>> call(String email) {
    return _repository.forgatePassword(email);
  }
}
