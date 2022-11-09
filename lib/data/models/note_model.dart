import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:just_notes/domain/entities/note.dart';

part 'note_model.freezed.dart';
part 'note_model.g.dart';

@freezed
class NoteModel with _$NoteModel {
  factory NoteModel({
    int? id,
    required String title,
    required String content
  }) = _NoteModel;

  factory NoteModel.fromJson(Map<String, dynamic> json) => _$NoteModelFromJson(json);
}

extension NoteModelX on NoteModel {
  Note toEntity() => Note(
    id: id,
    title: title,
    content: content
  );
}
