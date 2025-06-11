import 'dart:async';

import 'package:dio/dio.dart';
import 'package:exodus/core/constants/api/api_constants_endpoints.dart';
import 'package:exodus/core/constants/app/key_constants.dart';
import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/core/network/models/base_response.dart';
import 'package:exodus/core/network/dio_error_handler.dart';
import 'package:exodus/core/services/secure_store_services.dart';
import 'package:exodus/core/utils/debug_logger.dart';

import 'models/error_response.dart';

class ApiClient {
  late final Dio _dio;

  // Dio get dio => _dio;

  bool _isRefreshing = false;
  final List<Completer<void>> _pendingRequests = [];

  // Singleton instance
  static ApiClient? _instance;

  final SecureStoreServices _secureStoreServices = SecureStoreServices();

  factory ApiClient() {
    _instance ??= ApiClient._internal();
    _instance!._initialize();
    return _instance!;
  }

  ApiClient._internal();

  Future<void> _initialize() async {
    dPrint("Api Initialized");
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 60),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    // Add interceptors
    // _dio.interceptors.add(TokenRefreshInterceptor(this, _secureStoreServices));
    // _dio.interceptors.add(CustomCacheInterceptor());
  }

  // Add the refreshToken method here - it should be private
  Future<bool> _refreshToken() async {
    try {
      final refreshToken = await _secureStoreServices.retrieveData(
        KeyConstants.refreshToken,
      );

      if (refreshToken == null) {
        return false;
      }

      final response = await _dio.post(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.refreshToken}',
        data: {'refreshToken': refreshToken},
      );

      final baseResponse = BaseResponse<Map<String, dynamic>>.fromJson(
        response.data,
        (json) => json,
      );

      if (baseResponse.success && baseResponse.data != null) {
        final newAccessToken = baseResponse.data!['accessToken'] as String;
        final newRefreshToken = baseResponse.data!['refreshToken'] as String;

        await _secureStoreServices.storeData(
          KeyConstants.accessToken,
          newAccessToken,
        );
        await _secureStoreServices.storeData(
          KeyConstants.refreshToken,
          newRefreshToken,
        );

        return true;
      }
      return false;
    } catch (e) {
      dPrint("Refresh token error: $e");
      return false;
    }
  }

  /// [Api Methods] ------------------------------------------------------------------

  Future<ApiResult<T>> _request<T>({
    required String method,
    required String endpoint,
    required T Function(dynamic) fromJsonT,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    dPrint("Api Endpoint -> $endpoint $queryParameters");
    try {
      if (_isRefreshing) {
        final completer = Completer<void>();
        _pendingRequests.add(completer);
        await completer.future;
      }

      options = await _addAuthHeader(options);
      final response = await _dio.request(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options..method = method,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      final baseResponse = BaseResponse<T>.fromJson(response.data, fromJsonT);
      if (!baseResponse.success) {
        return ApiError(
          baseResponse.errorSources?.first.message ?? baseResponse.message,
        );
      }
      return ApiSuccess(baseResponse.data as T);
    } on DioException catch (error) {
      if (error.response?.statusCode == 401 && !_isRefreshing) {
        _isRefreshing = true;
        try {
          if (await _refreshToken()) {
            return _request<T>(
              method: method,
              endpoint: endpoint,
              fromJsonT: fromJsonT,
              data: data,
              queryParameters: queryParameters,
              options: options,
              cancelToken: cancelToken,
              onSendProgress: onSendProgress,
              onReceiveProgress: onReceiveProgress,
            );
          }
        } finally {
          _isRefreshing = false;
          for (var completer in _pendingRequests) {
            completer.complete();
          }
          _pendingRequests.clear();
        }
      }
      return _handleDioError<T>(error);
    } catch (e) {
      dPrint("Unexpected error: $e");
      return ApiError("An unexpected error occurred");
    }
  }

  Future<ApiResult<T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) fromJsonT,
    Options? options,
    CancelToken? cancelToken,
  }) => _request(
    method: 'GET',
    endpoint: endpoint,
    fromJsonT: fromJsonT,
    queryParameters: queryParameters,
    options: options,
    cancelToken: cancelToken,
  );

  Future<ApiResult<T>> post<T>(
    String endpoint, {
    dynamic data,
    required T Function(dynamic) fromJsonT,
    Options? options,
    CancelToken? cancelToken,
  }) => _request(
    method: 'POST',
    endpoint: endpoint,
    fromJsonT: fromJsonT,
    data: data,
    options: options,
    cancelToken: cancelToken,
  );

  Future<ApiResult<T>> patch<T>(
    String endpoint, {
    dynamic data,
    required T Function(dynamic) fromJsonT,
    Options? options,
    CancelToken? cancelToken,
  }) => _request(
    method: 'PATCH',
    endpoint: endpoint,
    fromJsonT: fromJsonT,
    data: data,
    options: options,
    cancelToken: cancelToken,
  );

  Future<ApiResult<T>> put<T>(
    String endpoint, {
    dynamic data,
    required T Function(dynamic) fromJsonT,
    Options? options,
    CancelToken? cancelToken,
  }) => _request(
    method: 'PUT',
    endpoint: endpoint,
    fromJsonT: fromJsonT,
    data: data,
    options: options,
    cancelToken: cancelToken,
  );

  /// [Helper Methods] -----------------------------------------------------------

  Future<Options> _addAuthHeader(Options? options) async {
    options ??= Options();

    final accessToken = await _secureStoreServices.retrieveData(
      KeyConstants.accessToken,
    );

    dPrint("Current Access Token: $accessToken");

    if (accessToken != null) {
      options.headers ??= {};
      options.headers!['Authorization'] = 'Bearer $accessToken';
    }
    dPrint("Authorization header : ${options.headers}");
    return options;
  }

  ApiResult<T> _handleDioError<T>(DioException error) {
    dPrint("** Dio Error: ${error.message}");
    // Check if we have a response with error details
    if (error.response != null) {
      try {
        final responseData = error.response?.data;
        if (responseData is Map) {
          if (responseData.containsKey('errorSources')) {
            final errorResponse = ErrorResponse.fromJson(
              responseData as Map<String, dynamic>,
            );
            return ApiError(errorResponse.combinedErrorMessage);
          }
          if (responseData.containsKey('message')) {
            return ApiError(responseData['message'] as String);
          }
        }
      } catch (e) {
        dPrint("Error parsing error response: $e");
      }
    }

    // Fall back to status code or Dio error type
    return ApiError(dioErrorToUserMessage(error));
  }
}
