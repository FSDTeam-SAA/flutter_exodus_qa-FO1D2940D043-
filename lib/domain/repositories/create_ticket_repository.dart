import 'package:exodus/data/models/ticket/ticket_model.dart';

import '../../core/network/network_result.dart';

abstract class CreateTicketRepository {
  NetworkResult<TicketModel> generateTicket(
    String seatNumber,
    String busNumber,
    String source,
    String destination,
    DateTime date,
  );
}
