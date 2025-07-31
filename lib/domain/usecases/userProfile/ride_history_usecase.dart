import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/data/models/ticket/ticket_model.dart';
import 'package:exodus/domain/repositories/ride_history_repository.dart';

class RideHistoryUsecase {
  final RideHistoryRepository _rideHistoryRepository;

  RideHistoryUsecase(this._rideHistoryRepository);

  Future<ApiResult<List<TicketModel>>>  call() async {
    return await _rideHistoryRepository.getAllRideHistory();
  }
}
