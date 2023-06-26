class Note {
  Note(
      {this.id,
      this.userId,
      this.title,
      this.content,
      this.important,
      this.createAt});

  final int? id;
  final int? userId;
  final String? title;
  final String? content;
  final int? important;
  final int? createAt;
}
