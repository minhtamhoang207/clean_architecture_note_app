class AddNoteParams {
  AddNoteParams(
      {required this.title,
      required this.content,
      required this.important,
      required this.createAt,
      required this.userId});

  final String title;
  final String content;
  final int important;
  final int createAt;
  final int userId;

  Map<String, dynamic> toMap() => {
        'title': title,
        'content': content,
        'important': important,
        'create_at': createAt,
        'user_id': userId
      };
}
