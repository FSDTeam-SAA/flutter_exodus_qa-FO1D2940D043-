// class LoginResponse {
//   final String accessToken;
//   final String refreshToken;

//   LoginResponse({
//     required this.accessToken,
//     required this.refreshToken,
//   });

//   factory LoginResponse.fromJson(Map<String, dynamic> json) {
//     return LoginResponse(
//       accessToken: json['accessToken'] as String,
//       refreshToken: json['refreshToken'] as String,
//     );
//   }
// }

// class LoginData {
//   final LoginResponse data;

//   LoginData({
//     required this.data,
//   });

//   factory LoginData.fromJson(Map<String, dynamic> json) {
//     return LoginData(
//       data: LoginResponse.fromJson(json['data'] as Map<String, dynamic>),
//     );
//   }
// }