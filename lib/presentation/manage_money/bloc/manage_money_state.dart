part of 'manage_money_bloc.dart';

enum ManageMoneyStatus { initial, loading, success, failure, empty }

class ManageMoneyState extends Equatable {
  const ManageMoneyState._(
      {this.status = ManageMoneyStatus.initial,
      this.listUserExpense = const [],
      this.errorMessage,
      this.totalExpense = 0,
      this.totalIncome = 0,
      this.showIncome = false,
      this.showExpense = false});

  final ManageMoneyStatus status;
  final List<UserExpense> listUserExpense;
  final String? errorMessage;
  final int totalIncome;
  final int totalExpense;
  final bool showIncome;
  final bool showExpense;

  const ManageMoneyState.initial() : this._();

  const ManageMoneyState.loading() : this._(status: ManageMoneyStatus.loading);

  const ManageMoneyState.success(
      {required List<UserExpense> listUserExpense,
      required int totalIncome,
      required int totalExpense})
      : this._(
            status: ManageMoneyStatus.success,
            listUserExpense: listUserExpense,
            totalExpense: totalExpense,
            totalIncome: totalIncome);

  const ManageMoneyState.empty() : this._(status: ManageMoneyStatus.empty);

  const ManageMoneyState.failure({String? errorMessage})
      : this._(status: ManageMoneyStatus.failure, errorMessage: errorMessage);

  @override
  List<Object?> get props => [
        status,
        listUserExpense,
        errorMessage,
        totalExpense,
        totalIncome,
        showExpense,
        showIncome
      ];
}
