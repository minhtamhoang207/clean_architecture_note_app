part of 'manage_money_bloc.dart';

abstract class ManageMoneyEvent extends Equatable {
  const ManageMoneyEvent();
}

class GetAllUserExpense extends ManageMoneyEvent {
  const GetAllUserExpense({this.userId});
  final int? userId;

  @override
  List<Object?> get props => [userId];
}

class DeleteExpense extends ManageMoneyEvent {
  const DeleteExpense({required this.expenseId, this.userId});

  final int expenseId;
  final int? userId;

  @override
  List<Object?> get props => [expenseId, userId];
}

class ToggleShowExpense extends ManageMoneyEvent {
  const ToggleShowExpense({required this.showExpense});

  final bool showExpense;

  @override
  List<Object?> get props => [showExpense];
}

class ToggleShowIncome extends ManageMoneyEvent {
  const ToggleShowIncome({required this.showIncome});

  final bool showIncome;

  @override
  List<Object?> get props => [showIncome];
}