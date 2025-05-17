import 'package:exodus/data/models/bus/available_bus_response.dart';

class Driver {
  final String id;
  final String name;
  final String email;
  final String username;

  Driver({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
    );
  }
}

class BusInfo {
  final String id;
  final String name;
  final String busNumber;

  BusInfo({
    required this.id,
    required this.name,
    required this.busNumber,
  });

  factory BusInfo.fromJson(Map<String, dynamic> json) {
    return BusInfo(
      id: json['_id'] as String,
      name: json['name'] as String,
      busNumber: json['bus_number'] as String,
    );
  }
}

class AdminSchedule {
  final bool isActive;
  final String id;
  final List<ScheduleItem> schedules;
  final Driver driverId;
  final BusId busId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  AdminSchedule({
    required this.isActive,
    required this.id,
    required this.schedules,
    required this.driverId,
    required this.busId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory AdminSchedule.fromJson(Map<String, dynamic> json) {
    return AdminSchedule(
      isActive: json['isActive'] as bool,
      id: json['_id'] as String,
      schedules: (json['schedules'] as List)
          .map((e) => ScheduleItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      driverId: Driver.fromJson(json['driverId'] as Map<String, dynamic>),
      busId: BusId.fromJson(json['busId'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int,
    );
  }
}

class AdminScheduleData {
  final List<AdminSchedule> data;

  AdminScheduleData({
    required this.data,
  });

  factory AdminScheduleData.fromJson(Map<String, dynamic> json) {
    return AdminScheduleData(
      data: (json['data'] as List)
          .map((e) => AdminSchedule.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}