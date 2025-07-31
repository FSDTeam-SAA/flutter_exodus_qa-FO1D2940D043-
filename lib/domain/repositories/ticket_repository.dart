import 'package:exodus/data/models/ticket/ticket_model.dart';

abstract class TicketRepository {
  Future<TicketModel> createTicket({
    required String seatNumber,
    required String busNumber,
    required String source,
    required String destination,
    required DateTime date,
  });
  
  Future<List<TicketModel>> getAllTickets({
    required String busNumber,
    required String source,
    required String destination,
    required DateTime date,
    required String time,
  });

  Future<List<TicketModel>> getAdminAllTickets();
  Future<TicketModel> acceptStanding(String ticketId);
  Future<TicketModel> cancelTicket(String ticketId);
  Future<TicketModel> scanQr(String ticketId, String secret, String stationName);
}