class Chat {
  Chat({
    required this.createdAt,
    required this.userImage,
    required this.text,
    required this.userId,
    required this.username,
    required this.id,
  });
  late final String createdAt;
  late final String userImage;
  late final String text;
  late final String userId;
  late final String username;
  late final String id;

  Chat.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'] ?? '';
    userImage = json['userImage'] ?? '';
    text = json['text'] ?? '';
    userId = json['userId'] ?? '';
    username = json['username'] ?? '';
    id = json['id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['userImage'] = userImage;
    data['text'] = text;
    data['userId'] = userId;
    data['username'] = username;
    data['id'] = id;
    return data;
  }
}
