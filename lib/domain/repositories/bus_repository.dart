import 'package:exodus/data/models/bus_model.dart';

abstract class BusRepository {
  Future<List<Bus>> getAllBuses();
  Future<Bus> createBus(Bus bus);
  Future<Bus> updateBus(String busId, Bus bus);
  Future<void> deleteBus(String busId);
  Future<List<Bus>> getAvailableBuses({
    required String from,
    required String to,
    required DateTime date,
  });
  Future<Bus> getBusWithSeats({
    required String busId,
    required String source,
    required String destination,
    required DateTime date,
    required String time,
  });
}
