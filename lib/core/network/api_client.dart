import 'dart:async';

import 'package:dio/dio.dart';
import 'package:exodus/core/constants/api/api_constants_endpoints.dart';
import 'package:exodus/core/constants/app/key_constants.dart';
import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/core/network/api_result_mapper.dart';
import 'package:exodus/core/network/base_response.dart';
import 'package:exodus/core/network/dio_error_handler.dart';
import 'package:exodus/core/network/interceptor/custom_cache_interceptor.dart';
import 'package:exodus/core/network/interceptor/token_refresh_interceptor.dart';
import 'package:exodus/core/services/secure_store_services.dart';
import 'package:exodus/core/utils/debug_logger.dart';

class ApiClient {
  late final Dio _dio;

  Dio get dio => _dio;

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
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
        // // Don't throw for 4xx errors - we'll handle them manually
        // validateStatus: (status) => status != 400,
      ),
    );

    // Add interceptors
    _dio.interceptors.add(TokenRefreshInterceptor(this, _secureStoreServices));
    _dio.interceptors.add(CustomCacheInterceptor());
  }

  // Add the refreshToken method here - it should be private
  Future<bool> refreshToken() async {
    try {
      final refreshToken = await _secureStoreServices.retrieveData(
        KeyConstants.refreshToken,
      );

      if (refreshToken == null) {
        return false;
      }

      final response = await _dio.post(
        ApiEndpoints.refreshToken,
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

  Future<ApiResult<T>> get<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    required T Function(dynamic json) fromJsonT,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        data: queryParameters,
        queryParameters: queryParameters,
        options: await _addAuthHeader(options),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      dPrint("Get Response API -> $response");

      final baseResponse = BaseResponse<T>.fromJson(response.data, fromJsonT);

      dPrint("Base Response Message -> ${baseResponse.success}");

      return mapBaseResponse<T>(baseResponse);
    } on DioException catch (error) {
      final message = dioErrorToUserMessage(error);
      return ApiError(message);
    }
  }

  Future<ApiResult<T>> post<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    required T Function(dynamic json) fromJsonT,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: await _addAuthHeader(options),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      dPrint(" Base Api Response -> $response");
      final baseResponse = BaseResponse<T>.fromJson(response.data, fromJsonT);
      // dPrint(" Base Api Response -> $baseResponse");

      return mapBaseResponse<T>(baseResponse);
    } on DioException catch (error) {
      final message = dioErrorToUserMessage(error);
      dPrint("Post Error message -> $error");
      return ApiError(message);
    } catch (e) {
      dPrint("Unexpected Error: $e");
      return ApiError("Unexpected error occurred.");
    }
  }

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
}
