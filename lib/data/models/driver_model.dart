// driver.dart
class Driver {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? avatarUrl;

  Driver({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.avatarUrl,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json['_id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        avatarUrl: json['avatar']?['url'],
      );
}