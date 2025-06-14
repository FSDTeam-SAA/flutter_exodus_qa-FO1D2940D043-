class UserProfileUpdateModel {
  final String id;
  final String? name;
  final String? avatar;

  UserProfileUpdateModel({
    required this.id,
    this.name,
    this.avatar,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    if (name != null) 'name': name,
    if (avatar != null) 'avatar': avatar,
  };

  // factory UserProfileUpdateModel.fromJson(Map<String, dynamic> json) {
  //   return UserProfileUpdateModel(
  //     id: json['id'],
  //     name: json['name'],
  //     avatar: json['avatar'],
  //   );
  // }
}
