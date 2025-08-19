import 'package:exodus/core/controller/base_controller.dart';
import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/core/network/extensions/either_extensions.dart';
import 'package:exodus/core/services/navigation_service.dart';
import 'package:exodus/core/utils/debug_logger.dart';
import 'package:exodus/data/models/ticket/ticket_model.dart';
import 'package:exodus/domain/usecases/bookARide/cancel_ticket_usecase.dart';
import 'package:exodus/domain/usecases/bookARide/create_ticket_usecase.dart';
import 'package:flutter/widgets.dart';

class CreateTicketController extends BaseController {
  final CreateTicketUsecase _createTicketUsecase;
  final CancelTicketUsecase _cancelTicketUsecase;

  CreateTicketController(this._createTicketUsecase, this._cancelTicketUsecase);

  Future<TicketModel> createTicket(
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

      result.fold(
        (failure) {
          setError(failure.message);
          dPrint("Ticket creation error: ${failure.message}");
          throw Exception("Failed to create ticket");
        },
        (data) {
          dPrint("Create Ticket data result -> ${data}");
          return data;
        },
      );

      // if (result is ApiSuccess<TicketModel>) {
      //   dPrint("Ticket Is create -> ${result}");
      //   return result.data;
      // } else {
      //   // Return an ApiError with a suitable message if creation failed
      //   // return ApiError<TicketModel>("Failed to create ticket");
      //   throw Exception("Failed to create ticket");
      // }
    } catch (e) {
      dPrint(e);
    }
    throw Exception("Failed to create ticket");
  }

  Future<void> cancelTicket(String busId) async {
    try {
      final result = await _cancelTicketUsecase.call(busId);

      dPrint(result);

      result.handle(
        onSuccess: (data) {
          // dPrint("Cencal Ticket success $data");
          NavigationService().backtrack();
        },
        onFailure: (failure) {
          dPrint("Cencel Ticket error -> ${failure.message}");
          setError(failure.message);
          notifyListeners();
        },
      );

      // if (result is ApiSuccess<void>) {
      //   dPrint("Cencal Ticket success ${result}");
      //   NavigationService().backtrack();
      // } else {
      //   final message = (result as ApiError).message;
      //   dPrint("Cencel Ticket error -> $message");
      // }
    } catch (e) {
      print(e);
    }
  }
}
