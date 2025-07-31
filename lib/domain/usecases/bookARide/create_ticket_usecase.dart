import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/data/models/ticket/ticket_model.dart';
import 'package:exodus/domain/repositories/create_ticket_repository.dart';

class CreateTicketUsecase {
  final CreateTicketRepository _createTicketRepository;

  CreateTicketUsecase(this._createTicketRepository);

  Future<ApiResult<TicketModel>> call(
    String seatNumber,
    String busNumber,
    String source,
    String destination,
    DateTime date,
  ) async {
     return _createTicketRepository.generateTicket(seatNumber, busNumber, source, destination, date);
  }
}
