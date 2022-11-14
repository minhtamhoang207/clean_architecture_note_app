import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_param.freezed.dart';
part 'login_param.g.dart';

@freezed
class LoginParams with _$LoginParams {
  factory LoginParams({
    required String password,
    required String username,
  }) = _LoginParams;

  factory LoginParams.fromJson(Map<String, dynamic> json) => _$LoginParamsFromJson(json);
}