class NotificationModel {
  final String id;
  final String userId;
  final String message;
  final String type;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.message,
    required this.type,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      message: json['message'] ?? '',
      type: json['type'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'message': message,
      'type': type,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}