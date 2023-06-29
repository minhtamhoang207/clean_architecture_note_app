// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExpenseModel _$$_ExpenseModelFromJson(Map<String, dynamic> json) =>
    _$_ExpenseModel(
      id: json['id'] as int?,
      userId: json['user_id'] as int,
      amount: json['amount'] as int,
      note: json['note'] as String?,
      createAt: json['create_at'] as int,
    );

Map<String, dynamic> _$$_ExpenseModelToJson(_$_ExpenseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'amount': instance.amount,
      'note': instance.note,
      'create_at': instance.createAt,
    };
