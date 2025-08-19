import 'package:exodus/core/constants/api/api_constants_endpoints.dart';
import 'package:exodus/core/network/api_client.dart';
import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/data/models/bus/available_bus_response.dart';
import 'package:exodus/domain/repositories/list_of_available_suttles_repository.dart';

import '../../core/network/network_result.dart';

class ListOfAvailableSuttlesImpl implements ListOfAvailableShuttlesRepository {
  final ApiClient _apiClient;

  ListOfAvailableSuttlesImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  NetworkResult<List<AvailableShuttle>> getAvailableShuttles({
    required String from,
    required String to,
    required String date,
  }) async {
    return _apiClient.get(
      ApiEndpoints.getAvailableBus,
      queryParameters: {'from': from, 'to': to, 'date': date},
      // fromJsonT:
      fromJsonT:
          (json) =>
              (json as List)
                  .map((item) => AvailableShuttle.fromJson(item))
                  .toList(),

      // fromJsonT: (json) => AvailableShuttle.fromJson(json),
      // (json) => List<AvailableShuttle>.from(
      //   json['data'].map((x) => AvailableShuttle.fromJson(x)),
      // ),
    );
  }
}
