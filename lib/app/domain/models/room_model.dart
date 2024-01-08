class RoomModel {
  final String name;
  final DateTime creationDate;
  final String? id;
  final List<String> users;

  RoomModel({
    required this.name,
    required this.creationDate,
    required this.id,
    required this.users,
  });

  RoomModel copyWith({
    String? name,
    DateTime? creationDate,
    String? id,
    List<String>? users,
  }) =>
      RoomModel(
        name: name ?? this.name,
        creationDate: creationDate ?? this.creationDate,
        id: id ?? this.id,
        users: users ?? this.users,
      );

  factory RoomModel.fromJson(Map<String, dynamic> json) => RoomModel(
        name: json["name"],
        creationDate: DateTime.tryParse(json["creationDate"]) ?? DateTime.now(),
        id: json["id"],
        users: List<String>.from(json["users"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "creationDate": creationDate.toIso8601String(),
        "id": id,
        "users": List<dynamic>.from(users.map((x) => x)),
      };
}
