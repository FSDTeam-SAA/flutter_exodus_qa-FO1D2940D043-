class ProfileUpdateResponse {
  final bool success;
  final String message;
  final UserData data;

  ProfileUpdateResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ProfileUpdateResponse.fromJson(Map<String, dynamic> json) {
    return ProfileUpdateResponse(
      success: json['success'],
      message: json['message'],
      data: UserData.fromJson(json['data']),
    );
  }
}

class UserData {
  final String id;
  final String name;
  final String email;
  final String username;
  final String phone;
  final int credit;
  final int fine;
  final String role;
  final Avatar? avatar;
  final String refreshToken;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.phone,
    required this.credit,
    required this.fine,
    required this.role,
    this.avatar,
    required this.refreshToken,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      username: json['username'],
      phone: json['phone'],
      credit: json['credit'],
      fine: json['fine'],
      role: json['role'],
      avatar: json['avatar'] != null ? Avatar.fromJson(json['avatar']) : null,
      refreshToken: json['refreshToken'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class Avatar {
  final String publicId;
  final String url;

  Avatar({required this.publicId, required this.url});

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
      publicId: json['public_id'],
      url: json['url'],
    );
  }
}