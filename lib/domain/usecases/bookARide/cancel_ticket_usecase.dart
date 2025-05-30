import 'package:exodus/domain/repositories/single_bus_repository.dart';

import '../../../core/network/api_result.dart';

class CancelTicketUsecase {
  final GetSingleBusRepository _getSingleBusRepository;

  CancelTicketUsecase(this._getSingleBusRepository);

  Future<ApiResult<void>> call(String busId) {
    return _getSingleBusRepository.cancelRide(busId);
  }
}
