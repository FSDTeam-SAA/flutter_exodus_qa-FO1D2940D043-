import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/data/models/ticket/ticket_model.dart';
import 'package:exodus/domain/repositories/ride_history_repository.dart';

import '../../../core/network/network_result.dart';

class RideHistoryUsecase {
  final RideHistoryRepository _rideHistoryRepository;

  RideHistoryUsecase(this._rideHistoryRepository);

  NetworkResult<List<TicketModel>>  call() async {
    return await _rideHistoryRepository.getAllRideHistory();
  }
}
