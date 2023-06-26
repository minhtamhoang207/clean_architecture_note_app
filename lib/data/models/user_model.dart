import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:just_notes/domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel(
      {required int id,
      String? name,
      String? avatar,
      @JsonKey(name: 'create_at') int? createAt}) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

extension UserModelX on UserModel {
  User toEntity() =>
      User(id: id, name: name, avatar: avatar, createAt: createAt);
}
