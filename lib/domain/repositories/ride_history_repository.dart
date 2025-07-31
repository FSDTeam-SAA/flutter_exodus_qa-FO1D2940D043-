import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/data/models/ticket/ticket_model.dart';

abstract class RideHistoryRepository {
  Future<ApiResult<List<TicketModel>>>  getAllRideHistory();
}