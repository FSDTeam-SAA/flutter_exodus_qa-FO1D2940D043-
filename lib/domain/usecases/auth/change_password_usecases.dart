import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/domain/repositories/auth_repository.dart';

import '../../../core/network/network_result.dart';

class ChangePasswordUseCase {
  final AuthRepository _repository;

  ChangePasswordUseCase(this._repository);

  NetworkResult<void> call(
    String email,
    String oldPassword,
    String newPassword,
  ) {
    return _repository.changePassword(email, oldPassword, newPassword);
  }
}
