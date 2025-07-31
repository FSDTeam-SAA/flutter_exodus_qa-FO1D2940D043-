class Stop {
  final String name;
  final String id;
  final double? latitude;
  final double? longitude;
  final double? price;

  Stop({
    required this.name,
    required this.id,
    this.latitude,
    this.longitude,
    this.price,
  });

  factory Stop.fromJson(Map<String, dynamic> json) => Stop(
    name: json['name'],
    id: json['_id'],
    latitude: json['latitude']?.toDouble(),
    longitude: json['longitude']?.toDouble(),
    price: json['price']?.toDouble(),
  );
}

class Schedule {
  final String date;
  final String day;
  final String arrivalTime;
  final String departureTime;

  Schedule({
    required this.date,
    required this.day,
    required this.arrivalTime,
    required this.departureTime,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
    date: json['date'],
    day: json['day'],
    arrivalTime: json['arrivalTime'],
    departureTime: json['departureTime'],
  );
}

class Bus {
  final String id;
  final String name;
  final String busNumber;
  final int seat;
  final int standing;
  final String source;
  final List<Stop> stops;
  final String lastStop;
  final int price;

  Bus({
    required this.id,
    required this.name,
    required this.busNumber,
    required this.seat,
    required this.standing,
    required this.source,
    required this.stops,
    required this.lastStop,
    required this.price,
  });

  factory Bus.fromJson(Map<String, dynamic> json) => Bus(
    id: json['_id'],
    name: json['name'],
    busNumber: json['bus_number'],
    seat: json['seat'],
    standing: json['standing'],
    source: json['source'],
    stops: List<Stop>.from(json['stops']?.map((x) => Stop.fromJson(x)) ?? []),
    lastStop: json['lastStop'],
    price: json['price'],
  );
}

class AvailableShuttle {
  final String id;
  final Schedule schedules;
  final String driverId;
  final Bus bus;
  final bool isActive;

  AvailableShuttle({
    required this.id,
    required this.schedules,
    required this.driverId,
    required this.bus,
    this.isActive = true,
  });

  factory AvailableShuttle.fromJson(Map<String, dynamic> json) => AvailableShuttle(
    id: json['_id'],
    schedules: Schedule.fromJson(json['schedules']),
    driverId: json['driverId'],
    bus: Bus.fromJson(json['busId']),
    isActive: json['isActive'] ?? true,
  );
}