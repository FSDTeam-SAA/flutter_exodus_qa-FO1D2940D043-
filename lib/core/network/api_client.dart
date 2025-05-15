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

  factory ApiClient() {
    _instance ??= ApiClient._internal();
    _instance!._initialize();
    return _instance!;
  }

  ApiClient._internal();

  Future<void> _initialize() async {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      ),
    );
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

      final base = BaseResponse<T>.fromJson(response.data, fromJsonT);

      return mapBaseResponse(base);
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

      dPrint(" Base Api Response -> ${response.data}");
      final baseResponse = BaseResponse<T>.fromJson(response.data, fromJsonT);
      // dPrint(" Base Api Response -> $baseResponse");

      return mapBaseResponse<T>(baseResponse);
    } on DioException catch (error) {
      final message = dioErrorToUserMessage(error);
      return ApiError(message);
    } catch (e) {
      dPrint("Unexpected Error: $e");
      return ApiError("Unexpected error occurred.");
    }
  }

  /// [Helper Methods] -----------------------------------------------------------

  Future<Options> _addAuthHeader(Options? options) async {
    options ??= Options();

    final accessToken = await SecureStoreServices().retrieveData(
      KeyConstants.accessToken,
    );

    if (accessToken != null) {
      options.headers ??= {};
      options.headers!['Authorization'] = accessToken;
    }
    dPrint("Authorization header : ${options.headers}");
    return options;
  }
}
