class AddNoteParams {
  AddNoteParams(this.title, this.content);

  final String title;
  final String content;

  Map<String, dynamic> toMap() => {
    'title': title,
    'content' : content,
  };
}