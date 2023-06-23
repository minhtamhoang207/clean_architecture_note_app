import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:just_notes/domain/entities/expense.dart';

part 'expense_model.freezed.dart';
part 'expense_model.g.dart';

@freezed
class ExpenseModel with _$ExpenseModel {
  factory ExpenseModel(
      {required int id,
      required int userId,
      required int amount,
      String? note,
      @JsonKey(name: 'create_at')
      required int createAt}) = _ExpenseModel;

  factory ExpenseModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseModelFromJson(json);
}

extension ExpenseX on ExpenseModel {
  Expense toEntity() => Expense(
      id: id, userId: userId, amount: amount, note: note, createAt: createAt);
}
