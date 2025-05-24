import 'dart:async';

import 'package:exodus/core/controller/base_controller.dart';
import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/core/utils/debug_logger.dart';
import 'package:exodus/data/models/ticket/ticket_model.dart';
import 'package:exodus/domain/usecases/userProfile/ride_history_usecase.dart';

class RideHistoryController extends BaseController {
  final RideHistoryUsecase _rideHistoryUsecase;

  final _getAllRideHistoryController = StreamController<List<TicketModel>>.broadcast();

  RideHistoryController(this._rideHistoryUsecase);

  // Ride History List
  Stream<List<TicketModel>> get getAllRideHistoryListStream =>
      _getAllRideHistoryController.stream;

  Future<List<TicketModel>> getAllRideHistory() async {
    final result = await _rideHistoryUsecase.call();
    if (result is ApiSuccess<List<TicketModel>>) {
      final rideHistoryData = result.data;
      _getAllRideHistoryController.add(rideHistoryData);

      dPrint("Ride History -> ${rideHistoryData.first.toString()}");
      return rideHistoryData;
    } else {
      final message = (result as ApiError).message;
      dPrint("Ride History -> $message");
      return [];
    }
  }
}
