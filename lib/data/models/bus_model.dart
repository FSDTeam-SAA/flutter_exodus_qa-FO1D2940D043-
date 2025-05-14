class Bus {
  final String id;
  final String name;
  final String busNumber;
  final int seat;
  final int standing;
  final String source;
  final List<BusStop> stops;
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
        busNumber: json['bus_number'] ?? json['busNumber'],
        seat: json['seat'],
        standing: json['standing'],
        source: json['source'],
        stops: List<BusStop>.from(json['stops'].map((x) => BusStop.fromJson(x))),
        lastStop: json['lastStop'],
        price: json['price'],
      );
}

class BusStop {
  final String name;
  final String id;

  BusStop({required this.name, required this.id});

  factory BusStop.fromJson(Map<String, dynamic> json) => BusStop(
        name: json['name'],
        id: json['_id'],
      );
}