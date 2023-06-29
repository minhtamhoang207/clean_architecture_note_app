part of 'add_expense_bloc.dart';

enum AddExpenseStatus { initial, loading, success, failure, empty }

class AddExpenseState extends Equatable {
  const AddExpenseState._({
    this.addExpenseStatus = AddExpenseStatus.initial,
    this.errorMessage,
    this.listFriend = const <User>[]
  });

  final String? errorMessage;
  final AddExpenseStatus addExpenseStatus;
  final List<User> listFriend;

  const AddExpenseState.initial() : this._();

  const AddExpenseState.loading()
      : this._(addExpenseStatus: AddExpenseStatus.loading);

  const AddExpenseState.success({required List<User> listFriend})
      : this._(
        addExpenseStatus: AddExpenseStatus.success,
        listFriend: listFriend
  );

  const AddExpenseState.failure({String? errorMessage})
      : this._(
      errorMessage: errorMessage,
      addExpenseStatus: AddExpenseStatus.failure
  );

  const AddExpenseState.empty() : this._();

  @override
  List<Object?> get props => [errorMessage, AddExpenseStatus, listFriend];
}