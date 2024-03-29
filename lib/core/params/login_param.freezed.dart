// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_param.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LoginParams _$LoginParamsFromJson(Map<String, dynamic> json) {
  return _LoginParams.fromJson(json);
}

/// @nodoc
mixin _$LoginParams {
  String get password => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoginParamsCopyWith<LoginParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginParamsCopyWith<$Res> {
  factory $LoginParamsCopyWith(
          LoginParams value, $Res Function(LoginParams) then) =
      _$LoginParamsCopyWithImpl<$Res, LoginParams>;
  @useResult
  $Res call({String password, String username});
}

/// @nodoc
class _$LoginParamsCopyWithImpl<$Res, $Val extends LoginParams>
    implements $LoginParamsCopyWith<$Res> {
  _$LoginParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? password = null,
    Object? username = null,
  }) {
    return _then(_value.copyWith(
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LoginParamsCopyWith<$Res>
    implements $LoginParamsCopyWith<$Res> {
  factory _$$_LoginParamsCopyWith(
          _$_LoginParams value, $Res Function(_$_LoginParams) then) =
      __$$_LoginParamsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String password, String username});
}

/// @nodoc
class __$$_LoginParamsCopyWithImpl<$Res>
    extends _$LoginParamsCopyWithImpl<$Res, _$_LoginParams>
    implements _$$_LoginParamsCopyWith<$Res> {
  __$$_LoginParamsCopyWithImpl(
      _$_LoginParams _value, $Res Function(_$_LoginParams) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? password = null,
    Object? username = null,
  }) {
    return _then(_$_LoginParams(
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LoginParams implements _LoginParams {
  _$_LoginParams({required this.password, required this.username});

  factory _$_LoginParams.fromJson(Map<String, dynamic> json) =>
      _$$_LoginParamsFromJson(json);

  @override
  final String password;
  @override
  final String username;

  @override
  String toString() {
    return 'LoginParams(password: $password, username: $username)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LoginParams &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.username, username) ||
                other.username == username));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, password, username);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LoginParamsCopyWith<_$_LoginParams> get copyWith =>
      __$$_LoginParamsCopyWithImpl<_$_LoginParams>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LoginParamsToJson(
      this,
    );
  }
}

abstract class _LoginParams implements LoginParams {
  factory _LoginParams(
      {required final String password,
      required final String username}) = _$_LoginParams;

  factory _LoginParams.fromJson(Map<String, dynamic> json) =
      _$_LoginParams.fromJson;

  @override
  String get password;
  @override
  String get username;
  @override
  @JsonKey(ignore: true)
  _$$_LoginParamsCopyWith<_$_LoginParams> get copyWith =>
      throw _privateConstructorUsedError;
}
