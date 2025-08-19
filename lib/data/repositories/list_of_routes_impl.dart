import 'package:exodus/core/constants/api/api_constants_endpoints.dart';
import 'package:exodus/core/network/api_client.dart';
import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/domain/repositories/list_of_routes_repository.dart';

import '../../core/network/network_result.dart';

class ListOfRoutesImpl implements ListOfRoutesRepository {
  final ApiClient _apiClient;

  ListOfRoutesImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  NetworkResult<List<String>> location() {
    return _apiClient.get(
      ApiEndpoints.getRouteList,
      fromJsonT: (json) => List<String>.from(json),
    );
  }
}
