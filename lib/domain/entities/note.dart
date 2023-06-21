import 'package:freezed_annotation/freezed_annotation.dart';

part 'note.freezed.dart';

@freezed
class Note with _$Note {
  const factory Note(
      {required int id,
      required String title,
      required String content,
      required int important,
      required int createAt}) = _Note;
}
