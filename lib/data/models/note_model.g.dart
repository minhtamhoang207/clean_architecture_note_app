// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NoteModel _$$_NoteModelFromJson(Map<String, dynamic> json) => _$_NoteModel(
      id: json['id'] as int?,
      userId: json['userId'] as int?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      important: json['important'] as int?,
      createAt: json['create_at'] as int?,
    );

Map<String, dynamic> _$$_NoteModelToJson(_$_NoteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'content': instance.content,
      'important': instance.important,
      'create_at': instance.createAt,
    };
