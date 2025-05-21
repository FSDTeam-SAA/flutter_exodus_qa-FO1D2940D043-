import 'package:dio/dio.dart';
import 'package:exodus/core/constants/api/api_constants_endpoints.dart';
import 'package:exodus/core/constants/app/key_constants.dart';
import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/core/network/api_result_mapper.dart';
import 'package:exodus/core/network/base_response.dart';
import 'package:exodus/core/network/dio_error_handler.dart';
import 'package:exodus/core/network/interceptor/custom_cache_interceptor.dart';
import 'package:exodus/core/services/secure_store_services.dart';
import 'package:exodus/core/utils/debug_logger.dart';

import 'package:synchronized/synchronized.dart';

class ApiClient {
  late final Dio _dio;
  // Singleton instance
  static ApiClient? _instance;

  bool _isRefreshingToken = false;
  final _refreshLock = Lock();
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
        // Don't throw for 4xx errors - we'll handle them manually
        validateStatus: (status) => status! < 500,
      ),
    );

    // Add interceptors - CACHE INTERCEPTOR FIRST
    _dio.interceptors.add(CustomCacheInterceptor());

    // Add interceptors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handle) async {
          if (error.response?.statusCode == 401 ||
              error.response?.statusCode == 403) {
            try {
              await _refreshLock.synchronized(() async {
                // Handle token refresh
                if (!_isRefreshingToken) {
                  _isRefreshingToken = true;

                  try {
                    await _refreshToken();

                    // Retry the original request
                    final response = await _retryRequest(error.requestOptions);
                    handle.resolve(response);
                  } catch (e) {
                    handle.reject(error);
                  } finally {
                    _isRefreshingToken = false;
                  }
                }
              });

              // update the request with new token
              final newToken = await _secureStoreServices.retrieveData(
                KeyConstants.accessToken,
              );

              error.requestOptions.headers['Authorization'] =
                  'Bearer $newToken';

              // Create a new request with updated headers
              final opts = Options(
                method: error.requestOptions.method,
                headers: error.requestOptions.headers,
              );

              // Retry the request
              final response = await _dio.request(
                error.requestOptions.path,
                data: error.requestOptions.data,
                queryParameters: error.requestOptions.queryParameters,
                options: opts,
              );

              handle.resolve(response);
            } catch (e) {
              // If refresh fails, clear tokens and reject
              await _secureStoreServices.deleteData(KeyConstants.accessToken);
              await _secureStoreServices.deleteData(KeyConstants.refreshToken);
              handle.reject(error);
            }
          } else {
            handle.next(error);
          }
        },
      ),
    );
  }

  Future<Response<dynamic>> _retryRequest(RequestOptions requestOptions) async {
    final option = Options(
      method: requestOptions.method,
      headers: await _addAuthHeader(null).then((opts) => opts.headers),
    );

    return _dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: option,
    );
  }

  Future<void> _refreshToken() async {
    try {
      final refreshToken = await _secureStoreServices.retrieveData(
        KeyConstants.refreshToken,
      );

      if (refreshToken == null || refreshToken.isEmpty) {
        throw Exception("No refresh token available");
      }

      // Create a temporary Dio instance without interceptors
      final tempDio = Dio(
        BaseOptions(
          baseUrl: ApiEndpoints.baseUrl,
          headers: {'Content-Type': 'application/json'},
          validateStatus: (status) => true, // Accept all status codes
        ),
      );

      final response = await tempDio.post(
        ApiEndpoints.refreshToken,
        data: {'refreshToken': refreshToken},
      );

      dPrint("Refresh Token Response: ${response.data}");

      if (response.statusCode != 200) {
        throw Exception("Refresh failed with status ${response.statusCode}");
      }

      // Validate response structure
      if (response.data['accessToken'] == null ||
          response.data['refreshToken'] == null) {
        throw Exception("Invalid token response format");
      }

      // Save new tokens
      await Future.wait([
        _secureStoreServices.storeData(
          KeyConstants.accessToken,
          response.data['accessToken'],
        ),
        _secureStoreServices.storeData(
          KeyConstants.refreshToken,
          response.data['refreshToken'],
        ),
      ]);

      dPrint("Tokens refreshed successfully");
    } catch (e) {
      dPrint("Token refresh error: $e");
      await _secureStoreServices.deleteData(KeyConstants.accessToken);
      await _secureStoreServices.deleteData(KeyConstants.refreshToken);
      throw Exception("Token refresh failed: ${e.toString()}");
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

      dPrint(response);

      final baseResponse = BaseResponse<T>.fromJson(response.data, fromJsonT);

      dPrint(baseResponse);

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

      dPrint(" Base Api Response -> ${response}");
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

    if (accessToken != null) {
      options.headers ??= {};
      options.headers!['Authorization'] = 'Bearer $accessToken';
      ;
    }
    dPrint("Authorization header : ${options.headers}");
    return options;
  }
}
