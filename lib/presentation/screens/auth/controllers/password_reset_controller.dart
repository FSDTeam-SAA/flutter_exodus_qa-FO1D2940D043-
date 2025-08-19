import 'package:exodus/core/controller/base_controller.dart';
import 'package:exodus/core/network/extensions/either_extensions.dart';
import 'package:exodus/core/utils/debug_logger.dart';
import 'package:exodus/domain/usecases/auth/change_password_usecases.dart';
import 'package:exodus/domain/usecases/auth/forgate_password_usecases.dart';
import 'package:exodus/domain/usecases/auth/reset_password_usecases.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/services/navigation_service.dart';

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

  // Reset Password
  Future<void> resetPassword(
    String email,
    String code,
    String newPassword,
  ) async {
    setLoading(true);
    notifyListeners();

    final result = await resetPasswordUseCase.call(email, code, newPassword);

    dPrint("Reset Password Result: $result");
    setLoading(false);
  }

  // Change Password
  Future<void> changePassword(
    String email,
    String oldPassword,
    String newPassword,
  ) async {
    setLoading(true);
    notifyListeners();

    final result = await changePasswordUseCase.call(
      email,
      oldPassword,
      newPassword,
    );

    result.handle(
      onSuccess: (data) {
        // Navigate to the bottom navigation bar or any other screen
        NavigationService().freshStartTo(AppRoutes.bottomNavbar);
      },
      onFailure: (failure) {
        setError(failure.message);
        notifyListeners();
      },
    );

    // if (result is ApiSuccess<void>) {
    //   NavigationService().freshStartTo(AppRoutes.bottomNavbar);
    // } else if (result is ApiError) {
    //   setError(result.message);
    //   notifyListeners();
    //   return;
    // }

    dPrint("Change Password Result: $result");
    setLoading(false);
  }
}
