import 'package:exodus/data/models/ticket_model.dart';

abstract class TicketRepository {
  Future<Ticket> createTicket({
    required String seatNumber,
    required String busNumber,
    required String source,
    required String destination,
    required DateTime date,
  });
  
  Future<List<Ticket>> getAllTickets({
    required String busNumber,
    required String source,
    required String destination,
    required DateTime date,
    required String time,
  });

  Future<List<Ticket>> getAdminAllTickets();
  Future<Ticket> acceptStanding(String ticketId);
  Future<Ticket> cancelTicket(String ticketId);
  Future<Ticket> scanQr(String ticketId, String secret, String stationName);
}