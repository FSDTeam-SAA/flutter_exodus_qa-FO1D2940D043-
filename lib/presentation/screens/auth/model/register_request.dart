class RegisterRequest {
  final String name;
  final String email;
  final String password;
  final String phone;
  final String? username;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    this.username,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      if (username != null) 'username': username,
    };
  }
}