class Ticket {
  final String id;
  final String scheduleId;
  final String userId;
  final int price;
  final String busNumber; // Assuming it's a stringified ObjectId
  final String seatNumber;
  final String source;
  final String destination;
  final DateTime date;
  final String time;
  final String status;
  final String key;
  final String qrCode;
  final List<String> availableSeats;

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
    required this.key,
    required this.qrCode,
    required this.availableSeats,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        id: json['_id'] ?? '',
        scheduleId: json['schedule'] ?? '',
        userId: json['userId'] ?? '',
        price: json['price'] ?? 0,
        busNumber: json['busNumber'] ?? '',
        seatNumber: json['seatNumber'] ?? '',
        source: json['source'] ?? '',
        destination: json['destination'] ?? '',
        date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
        time: json['time'] ?? '',
        status: json['status'] ?? 'pending',
        key: json['key'] ?? '',
        qrCode: json['qrCode'] ?? '',
        availableSeats: (json['avaiableSeat'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
      );
}
