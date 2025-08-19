import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/data/models/bus/single_bus_response.dart';

import '../../core/network/network_result.dart';

abstract class GetSingleBusRepository {
  NetworkResult<BusDetailResponse> getSingleBus(
    String busId,
    String sourse,
    String destinatino,
    String date,
    String time,
  );

  NetworkResult<void> cancelRide(String busId);
}
