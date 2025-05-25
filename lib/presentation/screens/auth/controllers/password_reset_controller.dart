import 'package:exodus/core/controller/base_controller.dart';
import 'package:exodus/core/utils/debug_logger.dart';
import 'package:exodus/domain/usecases/auth/change_password_usecases.dart';
import 'package:exodus/domain/usecases/auth/forgate_password_usecases.dart';
import 'package:exodus/domain/usecases/auth/reset_password_usecases.dart';

class PasswordResetController extends BaseController {
  // Use cases
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final ChangePasswordUseCase changePasswordUseCase;

  PasswordResetController({
    required this.forgotPasswordUseCase,
    required this.resetPasswordUseCase,
    required this.changePasswordUseCase,
  }) : super();

  // Forgot Password
  Future<void> forgotPassword(String email) async {
    setLoading(true);
    notifyListeners();

    final result = await forgotPasswordUseCase.call(email);

    dPrint("Forgot Password Result: $result");
    setLoading(false);

  }
}
