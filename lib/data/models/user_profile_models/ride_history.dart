import 'package:exodus/data/models/ticket/ticket_model.dart';

class RideHistoryData {
  final List<Ticket> data;

  RideHistoryData({
    required this.data,
  });

  factory RideHistoryData.fromJson(Map<String, dynamic> json) {
    return RideHistoryData(
      data: (json['data'] as List)
          .map((e) => Ticket.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}