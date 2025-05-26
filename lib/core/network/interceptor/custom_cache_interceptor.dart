import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:exodus/core/constants/api/cache_constants.dart';
import 'package:exodus/core/network/models/hive_cache_model.dart';
import 'package:exodus/core/utils/debug_logger.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CustomCacheInterceptor extends Interceptor {
  final Duration maxCacheAge;
  final Set<String> _excludedPaths;
  final Box<HiveCacheModel> _cacheBox;

  CustomCacheInterceptor({
    this.maxCacheAge = const Duration(minutes: 10),
    List<String>? excludedPaths,
  }) : _excludedPaths = Set.from(excludedPaths ?? []),
       _cacheBox = Hive.box<HiveCacheModel>(ApiCacheConstants.userCacheKey);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip non-GET requests and excluded paths
    if (options.method.toUpperCase() != 'GET' ||
        _excludedPaths.contains(options.path)) {
      return handler.next(options);
    }

    final key = _generateCacheKey(options);
    final cached = _cacheBox.get(key);

    if (cached != null) {
      final isExpired =
          DateTime.now().difference(cached.cachedAt) > maxCacheAge;

      if (!isExpired) {
        dPrint("Returning cached response for ${options.path}");
        try {
          final cachedData = jsonDecode(cached.responseBody);
          return handler.resolve(
            Response(
              requestOptions: options,
              data: cachedData,
              statusCode: 200,
              headers: Headers.fromMap({
                'x-cache': ['HIT'],
                'x-cache-age': [
                  DateTime.now()
                      .difference(cached.cachedAt)
                      .inSeconds
                      .toString(),
                ],
              }),
            ),
          );
        } catch (e) {
          dPrint("Error parsing cached data: $e");
          await _cacheBox.delete(key);
        }
      } else {
        dPrint("Cache expired for ${options.path}");
        await _cacheBox.delete(key);
      }
    }

    // Add cache-control header to request
    options.headers['Cache-Control'] = 'no-cache';
    handler.next(options);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    final options = response.requestOptions;

    // Only cache successful GET responses with specific criteria
    if (options.method.toUpperCase() == 'GET' &&
        response.statusCode == 200 &&
        response.data is Map<String, dynamic> &&
        (response.data as Map<String, dynamic>)['success'] == true &&
        !_excludedPaths.contains(options.path)) {
      final key = _generateCacheKey(options);
      dPrint("Caching response for ${options.path}");

      try {
        await _cacheBox.put(
          key,
          HiveCacheModel(
            responseBody: jsonEncode(response.data),
            cachedAt: DateTime.now(),
          ),
        );

        // Add cache info to response headers
        response.headers.add('x-cache', 'MISS');
      } catch (e) {
        dPrint("Error caching response: $e");
      }
    }

    handler.next(response);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;

    // Only attempt cache fallback for GET requests
    if (options.method.toUpperCase() == 'GET' &&
        !_excludedPaths.contains(options.path)) {
      final key = _generateCacheKey(options);
      final cached = _cacheBox.get(key);

      if (cached != null) {
        dPrint("Returning cached response after error for ${options.path}");
        try {
          final cachedData = jsonDecode(cached.responseBody);
          return handler.resolve(
            Response(
              requestOptions: options,
              data: cachedData,
              statusCode: 200,
              headers: Headers.fromMap({
                'x-cache': ['HIT (error fallback)'],
                'x-cache-age': [
                  DateTime.now()
                      .difference(cached.cachedAt)
                      .inSeconds
                      .toString(),
                ],
              }),
              statusMessage: 'OK (from cache on error)',
            ),
          );
        } catch (e) {
          dPrint("Error parsing cached data: $e");
          await _cacheBox.delete(key);
        }
      }
    }

    handler.next(err);
  }

  String _generateCacheKey(RequestOptions options) {
    // Include query parameters in cache key
    final query =
        options.queryParameters.isNotEmpty
            ? '?${Uri(queryParameters: options.queryParameters).query}'
            : '';
    return '${options.path}$query';
  }
}
