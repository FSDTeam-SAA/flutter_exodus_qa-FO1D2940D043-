class User {
  final String id;
  final String name;
  final String email;
  final String username;
  final int credit;
  final int fine;
  final String role;
  final String createdAt;
  final String updatedAt;
  final String refreshToken;
  final Avatar avatar;
  final VerificationInfo verificationInfo;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.credit,
    required this.fine,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.refreshToken,
    required this.avatar,
    required this.verificationInfo,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      username: json['username'],
      credit: json['credit'],
      fine: json['fine'],
      role: json['role'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      refreshToken: json['refreshToken'],
      avatar: Avatar.fromJson(json['avatar']),
      verificationInfo: VerificationInfo.fromJson(json['verificationInfo']),
    );
  }
}

class Avatar {
  final String publicId;
  final String url;

  Avatar({
    required this.publicId,
    required this.url,
  });

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
      publicId: json['public_id']?.toString().trim() ?? '',
      url: json['url'] ?? '',
    );
  }
}

class VerificationInfo {
  final String token;
  final bool verified;

  VerificationInfo({
    required this.token,
    required this.verified,
  });

  factory VerificationInfo.fromJson(Map<String, dynamic> json) {
    return VerificationInfo(
      token: json['token'],
      verified: json['verified'],
    );
  }
}
