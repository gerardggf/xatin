class MessageModel {
  final String user;
  final String timestamp;
  final String content;

  MessageModel({
    required this.user,
    required this.timestamp,
    required this.content,
  });

  MessageModel copyWith({
    String? user,
    String? timestamp,
    String? content,
  }) =>
      MessageModel(
        user: user ?? this.user,
        timestamp: timestamp ?? this.timestamp,
        content: content ?? this.content,
      );

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        user: json["user"],
        timestamp: json["timestamp"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "timestamp": timestamp,
        "content": content,
      };
}
