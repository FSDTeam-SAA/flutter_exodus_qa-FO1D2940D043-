class ReservedBy {
  final String id;
  final String name;
  final String email;

  ReservedBy({
    required this.id,
    required this.name,
    required this.email,
  });

  factory ReservedBy.fromJson(Map<String, dynamic> json) {
    return ReservedBy(
      id: json['_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }
}

class Reservation {
  final String id;
  final String busNumber;
  final String time;
  final DateTime day;
  final double price;
  final int totalHour;
  final ReservedBy reservedBy;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Reservation({
    required this.id,
    required this.busNumber,
    required this.time,
    required this.day,
    required this.price,
    required this.totalHour,
    required this.reservedBy,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['_id'] as String,
      busNumber: json['bus_number'] as String,
      time: json['time'] as String,
      day: DateTime.parse(json['day'] as String),
      price: (json['price'] as num).toDouble(),
      totalHour: json['totalHour'] as int,
      reservedBy: ReservedBy.fromJson(json['reservedBy'] as Map<String, dynamic>),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int,
    );
  }
}

class Meta {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int itemsPerPage;

  Meta({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemsPerPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json['currentPage'] as int,
      totalPages: json['totalPages'] as int,
      totalItems: json['totalItems'] as int,
      itemsPerPage: json['itemsPerPage'] as int,
    );
  }
}

class ReservationData {
  final List<Reservation> reservations;
  final Meta meta;

  ReservationData({
    required this.reservations,
    required this.meta,
  });

  factory ReservationData.fromJson(Map<String, dynamic> json) {
    return ReservationData(
      reservations: (json['reservations'] as List)
          .map((e) => Reservation.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );
  }
}