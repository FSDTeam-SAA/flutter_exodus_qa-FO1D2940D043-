import 'package:exodus/core/constants/api/api_constants_endpoints.dart';
import 'package:exodus/core/network/api_client.dart';
import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/data/models/bus/single_bus_response.dart';
import 'package:exodus/domain/repositories/single_bus_repository.dart';

class GetSingleBustRepositoryImpl implements GetSingleBusRepository {
  final ApiClient _apiClient;

  GetSingleBustRepositoryImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<ApiResult<BusDetailResponse>> getSingleBus(
    String busId,
    String source,
    String destination,
    String date,
    String time,
  ) {
    return _apiClient.get<BusDetailResponse>(
      ApiEndpoints.getSingleBus + busId,
      queryParameters: {
        'source': source,
        'destination': destination,
        'date': date,
        'time': time,
      },
      fromJsonT: (json) => BusDetailResponse.fromJson(json),
    );
  }
}
