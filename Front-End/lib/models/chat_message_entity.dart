class ChatMessageEntity {
  String text;
  String? imageUrl;
  String id;
  int createdAt;
  Author author;

  ChatMessageEntity(
      {required this.text,
      required this.id,
      required this.createdAt,
      this.imageUrl,
      required this.author});

  factory ChatMessageEntity.fromJSON(Map<String, dynamic> json) {
    return ChatMessageEntity(
        text: json['text'],
        id: json['id'],
        createdAt: json['createdAt'],
        imageUrl: json['image'],
        author: Author.fromJSON(json['author']));
  }
}

class Author {
  String username;

  Author({required this.username});

  factory Author.fromJSON(Map<String, dynamic> json) {
    return Author(username: json['username']);
  }
}
