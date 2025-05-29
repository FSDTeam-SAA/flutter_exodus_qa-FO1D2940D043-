import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/data/models/bus/single_bus_response.dart';

abstract class GetSingleBusRepository {
  Future<ApiResult<BusDetailResponse>> getSingleBus(
    String busId,
    String sourse,
    String destinatino,
    String date,
    String time,
  );
}
