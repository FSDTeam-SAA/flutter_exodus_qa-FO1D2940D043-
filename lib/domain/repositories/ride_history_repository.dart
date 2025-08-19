import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/data/models/ticket/ticket_model.dart';

import '../../core/network/network_result.dart';

abstract class RideHistoryRepository {
  NetworkResult<List<TicketModel>>  getAllRideHistory();
}