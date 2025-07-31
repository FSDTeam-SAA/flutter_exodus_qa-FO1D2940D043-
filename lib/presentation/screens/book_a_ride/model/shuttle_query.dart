class ShuttleQuery {
  final String from;
  final String to;
  final String date;

  ShuttleQuery({
    required this.from,
    required this.to,
    required this.date,
  });

  Map<String, dynamic> toQueryParameters() {
    return {
      'from': from,
      'to': to,
      'date': date,
    };
  }
}
