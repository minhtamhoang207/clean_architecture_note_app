part of 'manage_money_bloc.dart';

enum ManageMoneyStatus { initial, loading, success, failure, empty }

class ManageMoneyState extends Equatable {
  const ManageMoneyState._(
      {this.status = ManageMoneyStatus.initial,
        this.listUserExpense = const [],
        this.errorMessage});

  final ManageMoneyStatus status;
  final List<UserExpense> listUserExpense;
  final String? errorMessage;

  const ManageMoneyState.initial() : this._();

  const ManageMoneyState.loading() : this._(status: ManageMoneyStatus.loading);

  const ManageMoneyState.success({required List<UserExpense> listUserExpense}) : this._(
      status: ManageMoneyStatus.success,
      listUserExpense: listUserExpense
  );

  const ManageMoneyState.empty() : this._(status: ManageMoneyStatus.empty);

  const ManageMoneyState.failure({String? errorMessage})
      : this._(status: ManageMoneyStatus.failure, errorMessage: errorMessage);

  @override
  List<Object?> get props => [status, listUserExpense, errorMessage];
}
