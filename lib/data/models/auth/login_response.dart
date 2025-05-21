class LoginResponse {
  final String accessToken;
  final String refreshToken;
  final String role;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.role,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      role: json['role'] ?? '',
    );
  }

  bool get isUser => role.toLowerCase() == 'user';
  bool get isDriver => role.toLowerCase() == 'driver';
}

class LoginData {
  final LoginResponse data;

  LoginData({
    required this.data,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      data: LoginResponse.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}