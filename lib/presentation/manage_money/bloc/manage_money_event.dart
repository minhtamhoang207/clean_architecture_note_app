part of 'manage_money_bloc.dart';

abstract class ManageMoneyEvent extends Equatable {
  const ManageMoneyEvent();
}

class GetAllUserExpense extends ManageMoneyEvent {
  @override
  List<Object?> get props => [];
}