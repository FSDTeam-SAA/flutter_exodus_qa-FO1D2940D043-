import 'package:exodus/core/constants/app/key_constants.dart';
import 'package:exodus/core/services/secure_store_services.dart';

import '../../../core/constants/socket/socket_constants.dart';
import '../../../core/services/socket_service.dart';

class CheckAuthStatusUsecase {
  final SecureStoreServices _secureStoreServices;
  // final SocketService _socketService;

  CheckAuthStatusUsecase(this._secureStoreServices,);

  Future<String?> call() async {
    final token = await _secureStoreServices.retrieveData(KeyConstants.accessToken);
    if (token == null) {
      return null; // Token is invalid
    }

    // await _socketService.initializeSocket(authToken: token);

    SocketService().initializeSocket(SocketConstants.serverUrl, token);

    final role = await _secureStoreServices.retrieveData(KeyConstants.role);
    return role; // Return the role if token and role are valid
  }
}