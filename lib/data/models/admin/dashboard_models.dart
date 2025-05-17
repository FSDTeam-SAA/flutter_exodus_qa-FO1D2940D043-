class BookingStat {
  final int year;
  final int month;
  final int total;

  BookingStat({
    required this.year,
    required this.month,
    required this.total,
  });

  factory BookingStat.fromJson(Map<String, dynamic> json) {
    return BookingStat(
      year: json['year'] as int,
      month: json['month'] as int,
      total: json['total'] as int,
    );
  }
}

class BookingStatsData {
  final List<BookingStat> data;

  BookingStatsData({
    required this.data,
  });

  factory BookingStatsData.fromJson(Map<String, dynamic> json) {
    return BookingStatsData(
      data: (json['data'] as List)
          .map((e) => BookingStat.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}