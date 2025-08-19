import 'package:exodus/core/controller/base_controller.dart';
import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/core/network/extensions/either_extensions.dart';
import 'package:exodus/core/utils/debug_logger.dart';
import 'package:exodus/domain/usecases/auth/verify_otp_usecase.dart';

class VerifyCodeController extends BaseController {
  final VerfifyOTPUseCase _verifyOTPUseCase;

  VerifyCodeController(this._verifyOTPUseCase);

  Future<bool> verifyCode(String email, String code) async {
    try {
      setLoading(true);
      clearError();
      notifyListeners();
      bool returnResult = false;

      final result = await _verifyOTPUseCase.call(email, code);

      result.handle(
        onSuccess: (data) {
          returnResult = true;
        },
        onFailure: (failure) {
          setError(failure.message);
          dPrint("Verification error: ${failure.message}");
          returnResult = false;
        },
      );

      return returnResult;

      // if (result is ApiSuccess<void>) {
      //   dPrint("Verification successful");

      //   return true;
      // } else {
      //   final message = (result as ApiError).message;
      //   setError(message);
      //   dPrint("Verification error: $message");
      //   return false;
      // }
    } catch (e) {
      // setError(e.toString());
      dPrint("Exception during verification: $e");
      return false;
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }
}
