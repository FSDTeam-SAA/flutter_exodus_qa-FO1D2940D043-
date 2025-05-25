import 'package:exodus/core/controller/base_controller.dart';
import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/core/routes/app_routes.dart';
import 'package:exodus/core/services/navigation_service.dart';
import 'package:exodus/core/utils/debug_logger.dart';
import 'package:exodus/data/models/auth/user_response.dart';
import 'package:exodus/domain/usecases/auth/register_usecase.dart';
import 'package:exodus/presentation/screens/auth/model/register_request.dart';

class RegisterController extends BaseController {
  // Use cases
  final RegisterUsecase registerUseCase;

  RegisterController(this.registerUseCase);

  Future<void> register(RegisterRequest request) async {
    setLoading(true);
    notifyListeners();

    dPrint(
      "Registering with request: ${request.email}, ${request.name}, ${request.phone}, ${request.password}",
    );

    try {
      final result = await registerUseCase.call(request);
      dPrint("Register Result: $result");

      if (result is ApiSuccess<User>) {
        dPrint("Registration successful: ${result.data}");
        // Handle successful registration, e.g., navigate to login or home screen
        NavigationService().freshStartTo(AppRoutes.bottomNavbar);
      } else {
        final message = (result as ApiError).message;
        setError(message);
        dPrint(" Controller login message print $message");
        notifyListeners();
      }

      setLoading(false);
    } catch (e) {
      setError(e.toString());
      notifyListeners();
      return;
    }
  }
}
