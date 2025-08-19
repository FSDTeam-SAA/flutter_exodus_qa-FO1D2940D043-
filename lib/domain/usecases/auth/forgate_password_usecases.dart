import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/domain/repositories/auth_repository.dart';

import '../../../core/network/network_result.dart';

class ForgotPasswordUseCase {
  final AuthRepository _repository;

  ForgotPasswordUseCase(this._repository);

  NetworkResult<void> call(String email) {
    return _repository.forgatePassword(email);
  }
}
