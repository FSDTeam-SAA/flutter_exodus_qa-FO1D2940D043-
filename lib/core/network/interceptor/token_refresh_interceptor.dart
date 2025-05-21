import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TokenRefreshInterceptor extends Interceptor {
  final Future<String?> Function() refreshToken;
  final Future<void> Function(String newToken) saveToken;
  final Future<void> Function() logout;

  TokenRefreshInterceptor({
    required this.refreshToken,
    required this.saveToken,
    required this.logout,
  });

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    // Check for specific 403 "Invalid token" error
    if (_isTokenInvalidError(err)) {
      debugPrint('Detected invalid token, attempting refresh...');
      
      final newToken = await refreshToken();
      if (newToken != null) {
        debugPrint('Token refresh successful');
        
        // Update the request with new token
        err.requestOptions.headers['Authorization'] = newToken;
        
        // Create a new Dio instance to avoid circular interceptor calls
        final dio = Dio();
        
        // Repeat the request with new token
        try {
          final response = await dio.fetch(err.requestOptions);
          return handler.resolve(response);
        } catch (retryError) {
          debugPrint('Retry failed: $retryError');
          return handler.next(err);
        }
      } else {
        debugPrint('Token refresh failed - logging out');
        await logout();
        return handler.next(err);
      }
    }
    
    // For all other errors, just pass them through
    return handler.next(err);
  }

  bool _isTokenInvalidError(DioException err) {
    return err.response?.statusCode == 403 &&
           err.response?.data != null &&
           err.response?.data['message'] == 'Invalid token';
  }
}