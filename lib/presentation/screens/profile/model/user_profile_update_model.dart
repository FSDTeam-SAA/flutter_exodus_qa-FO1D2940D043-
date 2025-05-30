class UserProfileUpdateModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String username;

  UserProfileUpdateModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.username,
  });

  factory UserProfileUpdateModel.fromJson(Map<String, dynamic> json) => UserProfileUpdateModel(
        id: json['_id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'] ?? '',
        username: json['username'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'username': username,
      };
}
