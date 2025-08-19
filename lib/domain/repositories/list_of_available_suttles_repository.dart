import 'package:exodus/data/models/bus/available_bus_response.dart';

import '../../core/network/network_result.dart';

abstract class ListOfAvailableShuttlesRepository {
  NetworkResult<List<AvailableShuttle>> getAvailableShuttles({
    required String from,
    required String to,
    required String date,
  });
}

