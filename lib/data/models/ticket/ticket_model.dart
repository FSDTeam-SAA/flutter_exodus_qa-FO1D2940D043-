class Ticket {
  final String id;
  final String schedule;
  final String userId;
  final int price;
  final String busNumber;
  final String seatNumber;
  final String source;
  final String destination;
  final String date;
  final String time;
  final String status;
  final String ride;
  final String key;
  final String createdAt;
  final String updatedAt;
  final String qrCode;

  Ticket({
    required this.id,
    required this.schedule,
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
    required this.createdAt,
    required this.updatedAt,
    required this.qrCode,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['_id'],
      schedule: json['schedule'],
      userId: json['userId'],
      price: json['price'],
      busNumber: json['busNumber'],
      seatNumber: json['seatNumber'],
      source: json['source'],
      destination: json['destination'],
      date: json['date'],
      time: json['time'],
      status: json['status'],
      ride: json['ride'],
      key: json['key'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      qrCode: json['qrCode'],
    );
  }
}
