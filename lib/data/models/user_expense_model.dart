import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:just_notes/data/models/expense_model.dart';
import 'package:just_notes/data/models/user_model.dart';
import 'package:just_notes/domain/entities/user_expense.dart';

part 'user_expense_model.freezed.dart';
part 'user_expense_model.g.dart';

@freezed
class UserExpenseModel with _$UserExpenseModel {
  factory UserExpenseModel({
    required ExpenseModel expense,
    required UserModel user
  }) = _UserExpenseModel;

  factory UserExpenseModel.fromJson(Map<String, dynamic> json) =>
      _$UserExpenseModelFromJson(json);
}

extension UserExpenseX on UserExpenseModel {
  UserExpense toEntity() => UserExpense(
    user: user.toEntity(),
    expense: expense.toEntity()
  );
}
