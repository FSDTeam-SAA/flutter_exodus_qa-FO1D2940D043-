import 'package:exodus/data/models/bus/available_bus_response.dart';

class BusDetailResponse {
  final Bus bus;
  final List<String> availableSeats;
  final List<String> totalSeats;

  BusDetailResponse({
    required this.bus,
    required this.availableSeats,
    required this.totalSeats,
  });

  factory BusDetailResponse.fromJson(Map<String, dynamic> json) {
    return BusDetailResponse(
      bus: Bus.fromJson(json['bus']),
      availableSeats: List<String>.from(json['avaiableSeat']),
      totalSeats: List<String>.from(json['totalSeats']),
    );
  }
}