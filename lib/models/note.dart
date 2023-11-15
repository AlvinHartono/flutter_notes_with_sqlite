class Note {
  final int? id;
  final String title;
  final String content;
  final String createdAt;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  factory Note.fromMap(Map<String, dynamic> json) => Note(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "content": content,
        "createdAt": createdAt,
      };
}
