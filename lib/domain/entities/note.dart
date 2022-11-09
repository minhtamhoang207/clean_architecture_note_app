import 'package:freezed_annotation/freezed_annotation.dart';

part 'note.freezed.dart';

@freezed
class Note with _$Note {
  const factory Note({
    int? id,
    required String title,
    required String content
  }) = _Note;
}