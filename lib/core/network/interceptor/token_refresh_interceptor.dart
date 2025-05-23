import 'package:dio/dio.dart';
import 'package:exodus/core/utils/debug_logger.dart';

import '../../constants/app/key_constants.dart';
import '../../services/secure_store_services.dart';
import '../api_client.dart';

class TokenRefreshInterceptor extends Interceptor {
  final ApiClient _apiClient;
  final SecureStoreServices _secureStoreServices;

  TokenRefreshInterceptor(this._apiClient, this._secureStoreServices);

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    dPrint("Refresh Token Interceptor ...");

    if (err.response?.statusCode == 401) {
      // Check if it's an invalid token error
      final responseData = err.response?.data;
      if (responseData is Map && responseData['message'] == 'Invalid token') {
        // Attempt to refresh the token
        final isRefreshed = await _apiClient.refreshToken();
        
        if (isRefreshed) {
          // Retry the original request with the new token
          final options = err.requestOptions;
          
          // Get the new access token
          final accessToken = await _secureStoreServices.retrieveData(
            KeyConstants.accessToken,
          );
          
          // Update the header
          options.headers['Authorization'] = 'Bearer $accessToken';
          
          // Create a new request with the updated options
          final newRequest = await _apiClient.dio.fetch(options);
          return handler.resolve(newRequest);
        } else {
          // If refresh fails, you might want to logout the user
          // _logoutUser();
          return handler.reject(err);
        }
      }
    }
    return handler.next(err);
  }
}