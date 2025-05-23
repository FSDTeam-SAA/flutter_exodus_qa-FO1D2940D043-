import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:exodus/core/constants/api/cache_constants.dart';
import 'package:exodus/core/network/models/hive_cache_model.dart';
import 'package:exodus/core/utils/debug_logger.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CustomCacheInterceptor extends Interceptor {
  final Duration maxCacheAge;

  CustomCacheInterceptor({this.maxCacheAge = const Duration(minutes: 10)});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    dPrint("Cache Is coming in ...");

    // Only cache GET requests
    if (options.method.toUpperCase() != 'GET') {
      return handler.next(options);
    }

    final key = options.uri.toString();
    final box = Hive.box<HiveCacheModel>(ApiCacheConstants.userCacheKey);

    final cached = box.get(key);
    if (cached != null) {
      final isExpired = DateTime.now().difference(cached.cachedAt) > maxCacheAge;

      if (!isExpired) {
        return handler.resolve(
          Response(
            requestOptions: options,
            data: jsonDecode(cached.responseBody),
            statusCode: 200,
            statusMessage: 'OK (from cache)',
          ),
        );
      }
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.requestOptions.method.toUpperCase() == 'GET' && 
        response.statusCode == 200 &&
        response.data is Map<String, dynamic> &&
        (response.data as Map<String, dynamic>)['success'] == true) {
      final key = response.requestOptions.uri.toString();
      final box = Hive.box<HiveCacheModel>(ApiCacheConstants.userCacheKey);
      await box.put(
        key,
        HiveCacheModel(
          responseBody: jsonEncode(response.data),
          cachedAt: DateTime.now(),
        ),
      );
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.requestOptions.method.toUpperCase() == 'GET') {
      final key = err.requestOptions.uri.toString();
      final box = Hive.box<HiveCacheModel>(ApiCacheConstants.userCacheKey);
      final cached = box.get(key);

      if (cached != null) {
        return handler.resolve(
          Response(
            requestOptions: err.requestOptions,
            data: jsonDecode(cached.responseBody),
            statusCode: 200,
            statusMessage: 'OK (from cache on error)',
          ),
        );
      }
    }

    handler.next(err);
  }
}