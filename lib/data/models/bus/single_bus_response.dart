import 'package:exodus/data/models/bus/available_bus_response.dart';

class SingleBusData {
  final BusId bus;
  final List<String> availableSeat;

  SingleBusData({
    required this.bus,
    required this.availableSeat,
  });

  factory SingleBusData.fromJson(Map<String, dynamic> json) {
    return SingleBusData(
      bus: BusId.fromJson(json['bus'] as Map<String, dynamic>),
      availableSeat: (json['avaiableSeat'] as List).cast<String>(),
    );
  }
}