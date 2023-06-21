class AddNoteParams {
  AddNoteParams(
      {required this.title,
      required this.content,
      required this.important,
      required this.createAt});

  final String title;
  final String content;
  final int important;
  final int createAt;

  Map<String, dynamic> toMap() => {
        'title': title,
        'content': content,
        'important': important,
        'create_at': createAt
      };
}
