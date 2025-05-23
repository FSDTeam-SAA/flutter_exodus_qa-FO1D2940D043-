import 'package:exodus/core/constants/api/api_constants_endpoints.dart';
import 'package:exodus/core/network/api_client.dart';
import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/data/models/ticket/ticket_model.dart';
import 'package:exodus/domain/repositories/ride_history_repository.dart';

class RideHistoryImpl implements RideHistoryRepository {
  final ApiClient _apiClient;

  RideHistoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<ApiResult<List<TicketModel>>> getAllRideHistory() async {
    return _apiClient.get<List<TicketModel>>(
      ApiEndpoints.getAllNotification,
      fromJsonT:
          (json) =>
              (json as List).map((item) => TicketModel.fromJson(item)).toList(),
    );
  }
}
