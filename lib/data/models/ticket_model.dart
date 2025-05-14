class Ticket {
  final String id;
  final String scheduleId;
  final String userId;
  final int price;
  final String busNumber;
  final String seatNumber;
  final String source;
  final String destination;
  final DateTime date;
  final String time;
  final String status;
  final String ride;
  final String key;
  final String qrCode;
  final List<String>? availableSeats;

  Ticket({
    required this.id,
    required this.scheduleId,
    required this.userId,
    required this.price,
    required this.busNumber,
    required this.seatNumber,
    required this.source,
    required this.destination,
    required this.date,
    required this.time,
    required this.status,
    required this.ride,
    required this.key,
    required this.qrCode,
    this.availableSeats,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        id: json['_id'],
        scheduleId: json['schedule'],
        userId: json['userId'],
        price: json['price'],
        busNumber: json['busNumber'],
        seatNumber: json['seatNumber'],
        source: json['source'],
        destination: json['destination'],
        date: DateTime.parse(json['date']),
        time: json['time'],
        status: json['status'],
        ride: json['ride'],
        key: json['key'],
        qrCode: json['qrCode'] ?? '',
        availableSeats: json['avaiableSeat'] != null 
            ? List<String>.from(json['avaiableSeat'])
            : null,
      );
}