
class Ticket {
  final String id;
  final String scheduleId;
  final String userId;
  final double price;
  final String busNumber;
  final String seatNumber;
  final String source;
  final String destination;
  final DateTime date;
  final String time;
  final String? qrCode;
  final String? ticketSecret;
  final List<String>? availableSeat;
  final String status;
  final String key;
  final DateTime createdAt;
  final DateTime updatedAt;

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
    this.qrCode,
    this.ticketSecret,
    this.availableSeat,
    required this.status,
    required this.key,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['_id'] ?? '',
      scheduleId: json['schedule'] ?? '',
      userId: json['userId'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      busNumber: json['busNumber'] ?? '',
      seatNumber: json['seatNumber'] ?? '',
      source: json['source'] ?? '',
      destination: json['destination'] ?? '',
      date: DateTime.parse(json['date']),
      time: json['time'] ?? '',
      qrCode: json['qrCode'],
      ticketSecret: json['ticket_secret'],
      availableSeat: json['avaiableSeat'] != null 
          ? List<String>.from(json['avaiableSeat']) 
          : null,
      status: json['status'] ?? 'pending',
      key: json['key'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'schedule': scheduleId,
      'userId': userId,
      'price': price,
      'busNumber': busNumber,
      'seatNumber': seatNumber,
      'source': source,
      'destination': destination,
      'date': date.toIso8601String(),
      'time': time,
      'qrCode': qrCode,
      'ticket_secret': ticketSecret,
      'avaiableSeat': availableSeat,
      'status': status,
      'key': key,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Ticket copyWith({
    String? id,
    String? scheduleId,
    String? userId,
    double? price,
    String? busNumber,
    String? seatNumber,
    String? source,
    String? destination,
    DateTime? date,
    String? time,
    String? qrCode,
    String? ticketSecret,
    List<String>? availableSeat,
    String? status,
    String? key,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Ticket(
      id: id ?? this.id,
      scheduleId: scheduleId ?? this.scheduleId,
      userId: userId ?? this.userId,
      price: price ?? this.price,
      busNumber: busNumber ?? this.busNumber,
      seatNumber: seatNumber ?? this.seatNumber,
      source: source ?? this.source,
      destination: destination ?? this.destination,
      date: date ?? this.date,
      time: time ?? this.time,
      qrCode: qrCode ?? this.qrCode,
      ticketSecret: ticketSecret ?? this.ticketSecret,
      availableSeat: availableSeat ?? this.availableSeat,
      status: status ?? this.status,
      key: key ?? this.key,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}