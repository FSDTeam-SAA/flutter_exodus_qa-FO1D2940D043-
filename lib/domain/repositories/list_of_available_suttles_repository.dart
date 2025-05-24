import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/data/models/bus/available_bus_response.dart';

abstract class ListOfAvailableShuttlesRepository {
  Future<ApiResult<List<AvailableShuttle>>> getAvailableShuttles({
    required String from,
    required String to,
    required String date,
  });
}

