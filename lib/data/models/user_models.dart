class User {
  final String id;
  final String name;
  final String email;
  final String username;
  final int credit;
  final String role;
  final VerificationInfo verificationInfo;
  final String avatar;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.credit,
    required this.role,
    required this.verificationInfo,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['_id'] ?? '',
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        username: json['username'] ?? '',
        credit: json['credit'] ?? 0,
        role: json['role'] ?? 'user',
        verificationInfo: VerificationInfo.fromJson(json['verificationInfo'] ?? {}),
        avatar: (json['avatar'] != null && json['avatar']['url'] != null)
            ? json['avatar']['url']
            : '',
      );
}

class VerificationInfo {
  final String token;
  final bool verified;

  VerificationInfo({required this.token, required this.verified});

  factory VerificationInfo.fromJson(Map<String, dynamic> json) => VerificationInfo(
        token: json['token'] ?? '',
        verified: json['verified'] ?? false,
      );
}
