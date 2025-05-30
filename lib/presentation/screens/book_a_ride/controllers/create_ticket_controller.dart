import 'package:exodus/core/controller/base_controller.dart';
import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/core/services/navigation_service.dart';
import 'package:exodus/core/utils/debug_logger.dart';
import 'package:exodus/domain/usecases/bookARide/cancel_ticket_usecase.dart';
import 'package:exodus/domain/usecases/bookARide/create_ticket_usecase.dart';
import 'package:flutter/widgets.dart';

class CreateTicketController extends BaseController {
  final CreateTicketUsecase _createTicketUsecase;
  final CancelTicketUsecase _cancelTicketUsecase;

  CreateTicketController(this._createTicketUsecase, this._cancelTicketUsecase);

  Future<void> createTicket(
    String seatNumber,
    String busNumber,
    String source,
    String destination,
    DateTime date,
  ) async {
    try {
      final result = await _createTicketUsecase.call(
        seatNumber,
        busNumber,
        source,
        destination,
        date,
      );

      dPrint("Create Ticket data result -> ${result}");

      if (result is ApiSuccess<TickerMode>) {
        dPrint("Ticket Is create -> ${result}");
      }
    } catch (e) {
      dPrint(e);
    }
  }

  Future<void> cancelTicket(String busId) async {
    try {
      final result = await _cancelTicketUsecase.call(busId);

      dPrint(result);

      if (result is ApiSuccess<void>) {
        dPrint("Cencal Ticket success ${result}");
        NavigationService().backtrack();
      } else {
        final message = (result as ApiError).message;
        dPrint("Cencel Ticket error -> $message");
      }

    } catch (e) {
      print(e);
    }
  }
}
