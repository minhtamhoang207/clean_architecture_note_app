// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_expense_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserExpenseModel _$$_UserExpenseModelFromJson(Map<String, dynamic> json) =>
    _$_UserExpenseModel(
      expense: ExpenseModel.fromJson(json['expense'] as Map<String, dynamic>),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_UserExpenseModelToJson(_$_UserExpenseModel instance) =>
    <String, dynamic>{
      'expense': instance.expense,
      'user': instance.user,
    };
