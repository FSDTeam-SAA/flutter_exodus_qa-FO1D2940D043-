class ProfileUpdateRepository {
  final String id;
  // final String name;
  // final String email;
  // final String? phone;
  // final String username;
  final Avatar? avatar;

  ProfileUpdateRepository({
    required this.id,
    // required this.name,
    // required this.email,
    // this.phone,
    // required this.username,
    this.avatar,
  });

  // Convert JSON to ProfileUpdateRepository object
  factory ProfileUpdateRepository.fromJson(Map<String, dynamic> json) {
    return ProfileUpdateRepository(
      id: json['_id'] ?? json['id'],
      // name: json['name'],
      // email: json['email'],
      // phone: json['phone'],
      // username: json['username'],
      avatar: json['avatar'] != null ? Avatar.fromJson(json['avatar']) : null,
    );
  }

  // Convert ProfileUpdateRepository object to JSON (useful for sending updates)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      // 'name': name,
      // 'email': email,
      // 'phone': phone,
      // 'username': username,
      'avatar': avatar?.toJson(),
    };
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

  Map<String, dynamic> toJson() {
    return {
      'public_id': publicId,
      'url': url,
    };
  }
}