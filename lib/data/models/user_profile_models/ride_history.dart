import 'package:exodus/data/models/ticket/ticket_model.dart';

class RideHistoryData {
  final List<TicketModel> data;

  RideHistoryData({required this.data});

  factory RideHistoryData.fromJson(Map<String, dynamic> json) {
    return RideHistoryData(
      data:
          (json['data'] as List?)
              ?.map((e) => TicketModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [], // Return an empty list if 'data' is null
    );
  }

  Map<String, dynamic> toJson() {
    return {'data': data.map((e) => e.toJson()).toList()};
  }
}
