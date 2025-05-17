import 'package:exodus/core/constants/app/key_constants.dart';
import 'package:exodus/core/services/secure_store_services.dart';

class CheckAuthStatusUsecase {
  final SecureStoreServices _secureStoreServices;

  CheckAuthStatusUsecase(this._secureStoreServices);

  Future<bool> call() async {
    final token = await _secureStoreServices.retrieveData(KeyConstants.accessToken);
    return token != null;
  }
}