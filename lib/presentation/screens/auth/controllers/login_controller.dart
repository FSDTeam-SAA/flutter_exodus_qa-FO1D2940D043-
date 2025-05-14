import 'package:exodus/core/controller/base_controller.dart';
import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/core/utils/debug_logger.dart';
import 'package:exodus/domain/repositories/auth_repository.dart';

class LoginController extends BaseController {
  final AuthRepository _authRepository;

  LoginController(this._authRepository);

  Future<void> login(String email, String password) async {
    setLoading(true);
    clearError();

    final result = await _authRepository.login(email, password);

    if (result is ApiSuccess) {
      final data = (result as ApiSuccess).data;

      dPrint(data);
    } else {
      final message = (result as ApiError).message;

      dPrint(message);
    }

    // result.(
    //   success : (data) {
    //     setLoading(false);
    //   },
    //   error: (message) {
    //     setError(message);
    //     setLoading(false);
    //   }
    // )
  }
} 