class MessageModel {
  final String user;
  final DateTime creationDate;
  final String content;
  final String? id;

  MessageModel({
    required this.user,
    required this.creationDate,
    required this.content,
    required this.id,
  });

  MessageModel copyWith({
    String? user,
    DateTime? creationDate,
    String? content,
    String? id,
  }) =>
      MessageModel(
        user: user ?? this.user,
        creationDate: creationDate ?? this.creationDate,
        content: content ?? this.content,
        id: id ?? this.id,
      );

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        user: json["user"],
        creationDate: DateTime.tryParse(json["creationDate"]) ?? DateTime.now(),
        content: json["content"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "creationDate": creationDate.toIso8601String(),
        "content": content,
        "id": id,
      };
}
