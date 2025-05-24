import 'package:exodus/core/constants/api/api_constants_endpoints.dart';
import 'package:exodus/core/network/api_client.dart';
import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/domain/repositories/list_of_routes_repository.dart';

class ListOfRoutesImpl implements ListOfRoutesRepository {
  final ApiClient _apiClient;

  ListOfRoutesImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<ApiResult<List<String>>> location() {
    return _apiClient.get(
      ApiEndpoints.getRouteList,
      fromJsonT: (json) => List<String>.from(json),
    );
  }
}
