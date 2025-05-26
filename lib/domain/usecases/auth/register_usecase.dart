import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/data/models/auth/user_response.dart';
import 'package:exodus/domain/repositories/auth_repository.dart';
import 'package:exodus/presentation/screens/auth/model/register_request.dart';

class RegisterUsecase {
  final AuthRepository _authRepository;

  RegisterUsecase(this._authRepository);
  Future<ApiResult<User>> call(RegisterRequest request) {
    return _authRepository.register(
      RegisterRequest(
        name: request.name,
        email: request.email,
        password: request.password,
        phone: request.phone,
      ),
    );
  }
}
