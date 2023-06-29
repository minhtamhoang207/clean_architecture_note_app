// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_expense_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserExpenseModel _$UserExpenseModelFromJson(Map<String, dynamic> json) {
  return _UserExpenseModel.fromJson(json);
}

/// @nodoc
mixin _$UserExpenseModel {
  ExpenseModel get expense => throw _privateConstructorUsedError;
  UserModel get user => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserExpenseModelCopyWith<UserExpenseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserExpenseModelCopyWith<$Res> {
  factory $UserExpenseModelCopyWith(
          UserExpenseModel value, $Res Function(UserExpenseModel) then) =
      _$UserExpenseModelCopyWithImpl<$Res, UserExpenseModel>;
  @useResult
  $Res call({ExpenseModel expense, UserModel user});

  $ExpenseModelCopyWith<$Res> get expense;
  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class _$UserExpenseModelCopyWithImpl<$Res, $Val extends UserExpenseModel>
    implements $UserExpenseModelCopyWith<$Res> {
  _$UserExpenseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expense = null,
    Object? user = null,
  }) {
    return _then(_value.copyWith(
      expense: null == expense
          ? _value.expense
          : expense // ignore: cast_nullable_to_non_nullable
              as ExpenseModel,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ExpenseModelCopyWith<$Res> get expense {
    return $ExpenseModelCopyWith<$Res>(_value.expense, (value) {
      return _then(_value.copyWith(expense: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get user {
    return $UserModelCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_UserExpenseModelCopyWith<$Res>
    implements $UserExpenseModelCopyWith<$Res> {
  factory _$$_UserExpenseModelCopyWith(
          _$_UserExpenseModel value, $Res Function(_$_UserExpenseModel) then) =
      __$$_UserExpenseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ExpenseModel expense, UserModel user});

  @override
  $ExpenseModelCopyWith<$Res> get expense;
  @override
  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class __$$_UserExpenseModelCopyWithImpl<$Res>
    extends _$UserExpenseModelCopyWithImpl<$Res, _$_UserExpenseModel>
    implements _$$_UserExpenseModelCopyWith<$Res> {
  __$$_UserExpenseModelCopyWithImpl(
      _$_UserExpenseModel _value, $Res Function(_$_UserExpenseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expense = null,
    Object? user = null,
  }) {
    return _then(_$_UserExpenseModel(
      expense: null == expense
          ? _value.expense
          : expense // ignore: cast_nullable_to_non_nullable
              as ExpenseModel,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserExpenseModel implements _UserExpenseModel {
  _$_UserExpenseModel({required this.expense, required this.user});

  factory _$_UserExpenseModel.fromJson(Map<String, dynamic> json) =>
      _$$_UserExpenseModelFromJson(json);

  @override
  final ExpenseModel expense;
  @override
  final UserModel user;

  @override
  String toString() {
    return 'UserExpenseModel(expense: $expense, user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserExpenseModel &&
            (identical(other.expense, expense) || other.expense == expense) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, expense, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserExpenseModelCopyWith<_$_UserExpenseModel> get copyWith =>
      __$$_UserExpenseModelCopyWithImpl<_$_UserExpenseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserExpenseModelToJson(
      this,
    );
  }
}

abstract class _UserExpenseModel implements UserExpenseModel {
  factory _UserExpenseModel(
      {required final ExpenseModel expense,
      required final UserModel user}) = _$_UserExpenseModel;

  factory _UserExpenseModel.fromJson(Map<String, dynamic> json) =
      _$_UserExpenseModel.fromJson;

  @override
  ExpenseModel get expense;
  @override
  UserModel get user;
  @override
  @JsonKey(ignore: true)
  _$$_UserExpenseModelCopyWith<_$_UserExpenseModel> get copyWith =>
      throw _privateConstructorUsedError;
}
