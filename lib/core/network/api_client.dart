import 'package:dio/dio.dart';
import 'package:exodus/core/constants/api/api_constants_endpoints.dart';
import 'package:exodus/core/constants/app/key_constants.dart';
import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/core/network/api_result_mapper.dart';
import 'package:exodus/core/network/base_response.dart';
import 'package:exodus/core/network/dio_error_handler.dart';
import 'package:exodus/core/services/secure_store_services.dart';
import 'package:exodus/core/utils/debug_logger.dart';

class ApiClient {
  late final Dio _dio;
  // Singleton instance
  static ApiClient? _instance;

  bool _isRefreshingToken = false;
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

    // Add interceptors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handle) async {
          if (error.response?.statusCode == 401 ||
              error.response?.statusCode == 403) {
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

      if (refreshToken == null) throw Exception("No refresh token available");

      // Call refresh token
      final response = await _dio.post(
        ApiEndpoints.refreshToken,
        data: {'refreshToken': refreshToken},
      );

      dPrint("Refresh the Tokens -> ${response.data}");

      // Save New token
      final newAccessToken = response.data['accessToken'];
      final newRefreshToken = response.data['refreshToken'];

      await _secureStoreServices.storeData(
        KeyConstants.accessToken,
        newAccessToken,
      );
      await _secureStoreServices.storeData(
        KeyConstants.refreshToken,
        newRefreshToken,
      );
    } catch (e) {
      // Clear token if refresh fails
      await _secureStoreServices.deleteData(KeyConstants.accessToken);
      await _secureStoreServices.deleteData(KeyConstants.refreshToken);
      throw Exception("Token refresh failed");
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
      options.headers!['Authorization'] = 'Bearer $accessToken';;
    }
    dPrint("Authorization header : ${options.headers}");
    return options;
  }
}
