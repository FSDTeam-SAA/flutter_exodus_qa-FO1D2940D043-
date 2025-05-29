import 'package:exodus/data/models/ticket/ticket_model.dart';

import '../../core/network/api_result.dart';

abstract class CreateTicketRepository {
  Future<ApiResult<TicketModel>> generateTicket(
    String seatNumber,
    String busNumber,
    String source,
    String destination,
    DateTime date,
  );
}
