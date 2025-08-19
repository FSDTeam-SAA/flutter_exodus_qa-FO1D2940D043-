import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/data/models/auth/login_response.dart';
import 'package:exodus/domain/repositories/auth_repository.dart';

import '../../../core/network/network_result.dart';

class LoginUsecase {
  final AuthRepository _authRepository;

  LoginUsecase(this._authRepository);

  NetworkResult<LoginResponse> call(String email, String password) {
    return _authRepository.login(email, password);
  }
}
