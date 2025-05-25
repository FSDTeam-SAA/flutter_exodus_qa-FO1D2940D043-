import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/domain/repositories/auth_repository.dart';

class ChangePasswordUseCase {
  final AuthRepository _repository;

  ChangePasswordUseCase(this._repository);

  Future<ApiResult<void>> call(
    String email,
    String oldPassword,
    String newPassword,
  ) {
    return _repository.changePassword(email, oldPassword, newPassword);
  }
}
