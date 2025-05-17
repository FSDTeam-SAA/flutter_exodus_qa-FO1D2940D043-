import 'package:exodus/data/models/auth/register_response.dart';
import 'package:exodus/data/models/ticket/ticket_model.dart';

class UserData {
  final User user;
  final List<Ticket> ticket;

  UserData({required this.user, required this.ticket});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      user: User.fromJson(json['user']),
      ticket: (json['ticket'] as List).map((e) => Ticket.fromJson(e)).toList(),
    );
  }
}