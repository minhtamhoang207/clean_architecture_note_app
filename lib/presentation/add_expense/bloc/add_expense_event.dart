part of 'add_expense_bloc.dart';

abstract class AddExpenseEvent extends Equatable {
  const AddExpenseEvent();
}

class GetAllFriend extends AddExpenseEvent {
  @override
  List<Object?> get props => [];
}

class ConfirmAddExpense extends AddExpenseEvent {
  const ConfirmAddExpense({required this.expenseModel});
  final ExpenseModel expenseModel;

  @override
  List<Object?> get props => [expenseModel];
}

class SelectFriend extends AddExpenseEvent {
  const SelectFriend({required this.friend});
  final User? friend;

  @override
  List<Object?> get props => [friend];
}