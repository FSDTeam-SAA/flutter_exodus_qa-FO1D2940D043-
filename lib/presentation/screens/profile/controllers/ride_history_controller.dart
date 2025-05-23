import 'package:exodus/core/controller/base_controller.dart';
import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/core/utils/debug_logger.dart';
import 'package:exodus/data/models/ticket/ticket_model.dart';
import 'package:exodus/domain/usecases/userProfile/ride_history_usecase.dart';

class RideHistoryController extends BaseController {
  final RideHistoryUsecase _rideHistoryUsecase;

  RideHistoryController(this._rideHistoryUsecase);

  // List<RideHistoryData> rideHistory = [];

  Future<List<TicketModel>> getAllRideHistory() async {
    final result = await _rideHistoryUsecase.call();
    if (result is ApiSuccess<List<TicketModel>>) {
      final rideHistoryData = result.data;

      dPrint("Ride History -> ${rideHistoryData.first.id}");
      // dPrint("Ride History -> ${rideHistoryData.first.data.first.date}");
      return rideHistoryData;
    } else {
      final message = (result as ApiError).message;
      dPrint("Ride History -> $message");
      return [];
    }
  }
}
