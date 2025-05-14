// schedule.dart
import 'package:exodus/data/models/bus_model.dart';

class Schedule {
  final String id;
  final List<ScheduleDetail> schedules;
  final String driverId;
  final Bus bus;

  Schedule({
    required this.id,
    required this.schedules,
    required this.driverId,
    required this.bus,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json['_id'],
        schedules: List<ScheduleDetail>.from(
            json['schedules'].map((x) => ScheduleDetail.fromJson(x))),
        driverId: json['driverId'],
        bus: Bus.fromJson(json['busId']),
      );
}

class ScheduleDetail {
  final String day;
  final String arrivalTime;
  final String departureTime;
  final String? id;

  ScheduleDetail({
    required this.day,
    required this.arrivalTime,
    required this.departureTime,
    this.id,
  });

  factory ScheduleDetail.fromJson(Map<String, dynamic> json) => ScheduleDetail(
        day: json['day'],
        arrivalTime: json['arrivalTime'],
        departureTime: json['departureTime'],
        id: json['_id'],
      );
}