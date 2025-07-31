
class VerificationInfo {
  final bool verified;
  final String token;

  VerificationInfo({
    required this.verified,
    required this.token,
  });

  factory VerificationInfo.fromJson(Map<String, dynamic> json) {
    return VerificationInfo(
      verified: json['verified'] ?? false,
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'verified': verified,
      'token': token,
    };
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
      publicId: json['public_id'] ?? '',
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'public_id': publicId,
      'url': url,
    };
  }
}

class User {
  final String id;
  final String name;
  final String email;
  final String? password;
  final String username;
  final int? credit;
  final String role;
  final Avatar avatar;
  final VerificationInfo verificationInfo;
  final String passwordResetToken;
  final int fine;
  final String refreshToken;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.password,
    required this.username,
    this.credit,
    required this.role,
    required this.avatar,
    required this.verificationInfo,
    required this.passwordResetToken,
    required this.fine,
    required this.refreshToken,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'],
      username: json['username'] ?? '',
      credit: json['credit'],
      role: json['role'] ?? 'user',
      avatar: Avatar.fromJson(json['avatar'] ?? {}),
      verificationInfo: VerificationInfo.fromJson(json['verificationInfo'] ?? {}),
      passwordResetToken: json['password_reset_token'] ?? '',
      fine: json['fine'] ?? 0,
      refreshToken: json['refreshToken'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'password': password,
      'username': username,
      'credit': credit,
      'role': role,
      'avatar': avatar.toJson(),
      'verificationInfo': verificationInfo.toJson(),
      'password_reset_token': passwordResetToken,
      'fine': fine,
      'refreshToken': refreshToken,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? username,
    int? credit,
    String? role,
    Avatar? avatar,
    VerificationInfo? verificationInfo,
    String? passwordResetToken,
    int? fine,
    String? refreshToken,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      username: username ?? this.username,
      credit: credit ?? this.credit,
      role: role ?? this.role,
      avatar: avatar ?? this.avatar,
      verificationInfo: verificationInfo ?? this.verificationInfo,
      passwordResetToken: passwordResetToken ?? this.passwordResetToken,
      fine: fine ?? this.fine,
      refreshToken: refreshToken ?? this.refreshToken,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}