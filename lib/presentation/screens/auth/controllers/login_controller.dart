import 'package:exodus/core/controller/base_controller.dart';
import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/core/utils/debug_logger.dart';
import 'package:exodus/data/models/auth_response.dart';
import 'package:exodus/domain/repositories/auth_repository.dart';

class LoginController extends BaseController {
  final AuthRepository _authRepository;

  LoginController(this._authRepository);

  Future<void> login(String email, String password) async {
    setLoading(true);
    clearError();

    final result = await _authRepository.login(email, password);

    if (result is ApiSuccess<AuthResponse>) {
      final data = result.data;
      dPrint("Controller login print ->> ${data.accessToken}");
    } else {
      final message = (result as ApiError).message;
      dPrint(" Controller login message print ${message}");
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
