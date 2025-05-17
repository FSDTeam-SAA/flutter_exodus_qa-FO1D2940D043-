class NotificationData {
  final List<dynamic> data; // Replace with actual notification model if needed

  NotificationData({
    required this.data,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      data: json['data'] as List,
    );
  }
}