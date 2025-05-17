class ScheduleItem {
  final String day;
  final String arrivalTime;
  final String departureTime;
  final String id;

  ScheduleItem({
    required this.day,
    required this.arrivalTime,
    required this.departureTime,
    required this.id,
  });

  factory ScheduleItem.fromJson(Map<String, dynamic> json) {
    return ScheduleItem(
      day: json['day'] as String,
      arrivalTime: json['arrivalTime'] as String,
      departureTime: json['departureTime'] as String,
      id: json['_id'] as String,
    );
  }
}

class BusId {
  final String id;
  final String name;
  final String busNumber;
  final int seat;
  final int standing;
  final String source;
  final List<Map<String, String>> stops;
  final String lastStop;
  final int price;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  BusId({
    required this.id,
    required this.name,
    required this.busNumber,
    required this.seat,
    required this.standing,
    required this.source,
    required this.stops,
    required this.lastStop,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory BusId.fromJson(Map<String, dynamic> json) {
    return BusId(
      id: json['_id'] as String,
      name: json['name'] as String,
      busNumber: json['bus_number'] as String,
      seat: json['seat'] as int,
      standing: json['standing'] as int,
      source: json['source'] as String,
      stops: List<Map<String, String>>.from(
          (json['stops'] as List).map((stop) => {
                'name': (stop as Map<String, dynamic>)['name'] as String,
                '_id': (stop)['_id'] as String,
              })),
      lastStop: json['lastStop'] as String,
      price: json['price'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int,
    );
  }
}

class AvailableBus {
  final String id;
  final List<ScheduleItem> schedules;
  final String driverId;
  final BusId busId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  AvailableBus({
    required this.id,
    required this.schedules,
    required this.driverId,
    required this.busId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory AvailableBus.fromJson(Map<String, dynamic> json) {
    return AvailableBus(
      id: json['_id'] as String,
      schedules: (json['schedules'] as List)
          .map((e) => ScheduleItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      driverId: json['driverId'] as String,
      busId: BusId.fromJson(json['busId'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int,
    );
  }
}

class AvailableBusData {
  final List<AvailableBus> data;

  AvailableBusData({
    required this.data,
  });

  factory AvailableBusData.fromJson(Map<String, dynamic> json) {
    return AvailableBusData(
      data: (json['data'] as List)
          .map((e) => AvailableBus.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}