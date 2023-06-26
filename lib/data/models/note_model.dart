import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:just_notes/domain/entities/note.dart';

part 'note_model.freezed.dart';
part 'note_model.g.dart';

@freezed
class NoteModel with _$NoteModel {
  factory NoteModel(
      {int? id,
      int? userId,
      String? title,
      String? content,
      int? important,
      @JsonKey(name: 'create_at') int? createAt}) = _NoteModel;

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);
}

extension NoteModelX on NoteModel {
  Note toEntity() => Note(
      id: id,
      userId: userId,
      title: title,
      content: content,
      important: important,
      createAt: createAt);
}
