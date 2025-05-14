import 'package:exodus/data/models/ticket_model.dart';
import 'package:exodus/data/models/user_models.dart';

class AuthResponse {
  final String accessToken;
  final User user;
  final List<Ticket> tickets;

  AuthResponse({
    required this.accessToken,
    required this.user,
    required this.tickets,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        accessToken: json['accessToken'],
        user: User.fromJson(json['user']),
        tickets: List<Ticket>.from(json['ticket'].map((x) => Ticket.fromJson(x))),
      );
}