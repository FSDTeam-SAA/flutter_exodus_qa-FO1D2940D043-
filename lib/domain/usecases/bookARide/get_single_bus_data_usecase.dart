import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/data/models/bus/single_bus_response.dart';
import 'package:exodus/domain/repositories/single_bus_repository.dart';

class GetSingleBusDataUsecase {
  final GetSingleBusRepository _getSingleBusRepository;

  GetSingleBusDataUsecase(this._getSingleBusRepository);

  Future<ApiResult<BusDetailResponse>> call(
    String busId,
    String source,
    String destination,
    String date,
    String time,
  ) {
    return _getSingleBusRepository.getSingleBus(busId, source, destination, date, time);
  }
}
