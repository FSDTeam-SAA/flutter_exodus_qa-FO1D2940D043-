// lib/core/network/api_client.dart

import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:exodus/core/constants/api/api_constants_endpoints.dart';
import 'package:flutter/foundation.dart';
import 'package:flutx_core/flutx_core.dart';

import 'constants/api_constants.dart';
import 'constants/key_constants.dart';
import 'dio_error_handler.dart';
import 'interceptor/custom_cache_interceptor.dart';
import 'models/base_response.dart';
import 'models/network_failure.dart';
import 'services/connectivity_service.dart';
import 'services/secure_store_services.dart';

class ApiClient {
  late final Dio _dio;
  late final CustomCacheInterceptor _cacheInterceptor;
  late final ConnectivityService _connectivityService;

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
    if (kDebugMode) DPrint.log("Api Initialized");

    // Initialize connectivity service
    _connectivityService = ConnectivityService.instance;
    await _connectivityService.initialize();

    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseDomain,
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

    // Initialize cache interceptor
    _cacheInterceptor = CustomCacheInterceptor(
      maxCacheAge: const Duration(minutes: 15),
      staleWhileRevalidate: const Duration(minutes: 5),
      maxCacheSize: 1000,
      maxMemorySize: 5 * 1024 * 1024, // 5MB
      excludedPaths: ['/auth/', '/payment/', '/user/profile'],
    );

    _dio.interceptors.add(_cacheInterceptor);
  }

  /// Check connectivity before making requests
  Future<Either<NetworkFailure, void>> _checkConnectivity() async {
    if (!_connectivityService.isConnected) {
      // Try to wait for connection briefly
      try {
        await _connectivityService.waitForConnection(
          timeout: const Duration(seconds: 2),
        );
      } catch (e) {
        return const Left(NoInternetFailure());
      }
    }
    return const Right(null);
  }

  /// Refresh token method
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

      // Navigate to login screen - you'll need to implement this based on your navigation
      // Go.freshStartTo(LoginScreen());
      return false;
    } catch (e) {
      if (kDebugMode) DPrint.log("Refresh token error: $e");
      return false;
    }
  }

  /// Main request method using Either
  Future<Either<NetworkFailure, T>> _request<T>({
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
    final connectivityCheck = await _checkConnectivity();
    if (connectivityCheck.isLeft()) {
      return connectivityCheck.fold(
        (failure) => Left(failure),
        (_) => const Left(UnknownFailure(message: 'Connectivity check failed')),
      );
    }

    try {
      if (_isRefreshing) {
        final completer = Completer<void>();
        _pendingRequests.add(completer);
        await completer.future;
      }

      options = await _addAuthHeader(options);
      if (kDebugMode) {
        DPrint.log(
          "🛜  Api Endpoint -> $endpoint ${options.contentType} $method",
        );
      }

      final response = await _dio.request(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options..method = method,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      if (kDebugMode) DPrint.log("☁️  BASE Response -> ${response.data}");

      final baseResponse = BaseResponse<T>.fromJson(response.data, fromJsonT);
      if (!baseResponse.success) {
        return Left(
          ServerFailure(
            message: baseResponse.combinedErrorMessage,
            statusCode: response.statusCode ?? 400,
          ),
        );
      }

      return Right(baseResponse.data as T);
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
      return Left(_handleDioError(error));
    } catch (e) {
      if (kDebugMode) DPrint.log("Unexpected error: $e");
      return const Left(
        UnknownFailure(message: "An unexpected error occurred"),
      );
    }
  }

  /// HTTP Methods using Either
  Future<Either<NetworkFailure, T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) fromJsonT,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) => _request(
    method: 'GET',
    endpoint: endpoint,
    fromJsonT: fromJsonT,
    queryParameters: queryParameters,
    options: options,
    cancelToken: cancelToken,
    onReceiveProgress: onReceiveProgress,
  );

  Future<Either<NetworkFailure, T>> post<T>(
    String endpoint, {
    dynamic data,
    required T Function(dynamic) fromJsonT,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
  }) => _request(
    method: 'POST',
    endpoint: endpoint,
    fromJsonT: fromJsonT,
    data: data,
    options: options,
    cancelToken: cancelToken,
    onSendProgress: onSendProgress,
  );

  Future<Either<NetworkFailure, T>> patch<T>(
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

  Future<Either<NetworkFailure, T>> put<T>(
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

  Future<Either<NetworkFailure, T>> delete<T>(
    String endpoint, {
    dynamic data,
    required T Function(dynamic) fromJsonT,
    Options? options,
    CancelToken? cancelToken,
  }) => _request(
    method: 'DELETE',
    endpoint: endpoint,
    fromJsonT: fromJsonT,
    data: data,
    options: options,
    cancelToken: cancelToken,
  );

  Future<Either<NetworkFailure, T>> postFormData<T>(
    String endpoint, {
    required FormData formData,
    required T Function(dynamic) fromJsonT,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
  }) => _request(
    method: 'POST',
    endpoint: endpoint,
    fromJsonT: fromJsonT,
    data: formData,
    options: options ?? Options(headers: ApiEndpoints.multipartHeaders),
    cancelToken: cancelToken,
    onSendProgress: onSendProgress,
  );

  /// Helper Methods
  Future<Options> _addAuthHeader(Options? options) async {
    options ??= Options();

    final accessToken = await _secureStoreServices.retrieveData(
      KeyConstants.accessToken,
    );

    if (kDebugMode) DPrint.log("Current Access Token: $accessToken");

    if (accessToken != null) {
      options.headers ??= {};
      options.headers!['Authorization'] = 'Bearer $accessToken';
    }
    if (kDebugMode) DPrint.log("Authorization header : ${options.headers}");
    return options;
  }

  /// Updated error handling to return NetworkFailure instead of ApiResult
  NetworkFailure _handleDioError(DioException error) {
    if (kDebugMode) DPrint.log("** Dio Error: ${error.message}");

    // Check if we have a response with error details
    if (error.response != null) {
      try {
        final responseData = error.response?.data;
        if (responseData is Map) {
          if (responseData.containsKey('errorSources')) {
            final baseResponse = BaseResponse<void>.fromJson(
              responseData as Map<String, dynamic>,
              (json) {},
            );

            // Check if it's validation errors
            if (baseResponse.errorSources != null &&
                baseResponse.errorSources!.isNotEmpty) {
              return ValidationFailure(
                message: baseResponse.combinedErrorMessage,
                errors:
                    baseResponse.errorSources!.map((e) => e.message).toList(),
                statusCode: error.response?.statusCode ?? 400,
              );
            }

            return ServerFailure(
              message: baseResponse.combinedErrorMessage,
              statusCode: error.response?.statusCode ?? 400,
            );
          }
          if (responseData.containsKey('message')) {
            return ServerFailure(
              message: responseData['message'] as String,
              statusCode: error.response?.statusCode ?? 400,
            );
          }
        }
      } catch (e) {
        if (kDebugMode) DPrint.log("Error parsing error response: $e");
      }
    }

    // Handle specific error types
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutFailure(
          message: dioErrorToUserMessage(error),
          statusCode: error.response?.statusCode ?? 408,
        );

      case DioExceptionType.connectionError:
        return const ConnectionFailure(message: "No internet connection");

      default:
        if (error.response?.statusCode == 401) {
          return UnauthorizedFailure(
            message: dioErrorToUserMessage(error),
            statusCode: 401,
          );
        }

        return ServerFailure(
          message: dioErrorToUserMessage(error),
          statusCode: error.response?.statusCode ?? 0,
        );
    }
  }

  /// Get connectivity service instance
  ConnectivityService get connectivityService => _connectivityService;
}
