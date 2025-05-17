import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/data/models/auth/login_response.dart';
import 'package:exodus/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository _authRepository;

  LoginUsecase(this._authRepository);

  Future<ApiResult<LoginResponse>> call(String email, String password) {
    return _authRepository.login(email, password);
  }
}
