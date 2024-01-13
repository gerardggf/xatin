class UserModel {
  final String id;
  final String creationDate;
  final String username;
  final String email;
  final String? fcmToken;
  final String? photoUrl;

  UserModel({
    required this.id,
    required this.creationDate,
    required this.username,
    required this.email,
    required this.fcmToken,
    required this.photoUrl,
  });

  UserModel copyWith({
    String? id,
    String? creationDate,
    String? username,
    String? email,
    String? fcmToken,
    String? photoUrl,
  }) =>
      UserModel(
        id: id ?? this.id,
        creationDate: creationDate ?? this.creationDate,
        username: username ?? this.username,
        email: email ?? this.email,
        fcmToken: fcmToken ?? this.fcmToken,
        photoUrl: photoUrl ?? this.photoUrl,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        creationDate: json["creationDate"],
        username: json["username"],
        email: json["email"],
        fcmToken: json["fcmToken"],
        photoUrl: json["photoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "creationDate": creationDate,
        "username": username,
        "email": email,
        "fcmToken": fcmToken,
        "photoUrl": photoUrl,
      };
}
