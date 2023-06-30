import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:just_notes/domain/entities/user_expense.dart';
import 'package:just_notes/domain/usecases/expense_usecase/delete_expense.dart';
import 'package:just_notes/domain/usecases/expense_usecase/get_expenses_usecase.dart';

part 'manage_money_event.dart';
part 'manage_money_state.dart';

@injectable
class ManageMoneyBloc extends Bloc<ManageMoneyEvent, ManageMoneyState> {

  final GetExpenseUseCase _getUserExpenseUseCase;
  final DeleteExpenseUseCase _deleteExpenseUseCase;

  ManageMoneyBloc(this._getUserExpenseUseCase, this._deleteExpenseUseCase)
      : super(const ManageMoneyState.initial()) {
    on<GetAllUserExpense>(_onGetAllUserExpense);
    on<DeleteExpense>(_onDeleteExpense);
    on<ToggleShowExpense>(_onToggleShowExpense);
    on<ToggleShowIncome>(_onToggleShowIncome);
  }

  FutureOr<void> _onGetAllUserExpense(GetAllUserExpense event, Emitter<ManageMoneyState> emit) async {
    emit(const ManageMoneyState.loading());
    final response = await _getUserExpenseUseCase.call();
    int income = 0;
    int totalExpense = 0;
    response.fold(
            (l) => emit(ManageMoneyState.failure(errorMessage: l.toString())),
            (r) {
              if (event.userId != null) {
                r.removeWhere((element) => element.user?.id != event.userId);
              }

              for (UserExpense userExpense in r) {
                if ((userExpense.expense?.amount ?? 0) < 0) {
                  totalExpense += (userExpense.expense?.amount ?? 0);
                } else {
                  income += (userExpense.expense?.amount ?? 0);
                }
              }
              emit(ManageMoneyState.success(
                  listUserExpense: r,
                  totalIncome: income + totalExpense,
                  totalExpense: totalExpense
              ));
            }
    );
  }

  FutureOr<void> _onDeleteExpense(DeleteExpense event, Emitter<ManageMoneyState> emit) async {
    await _deleteExpenseUseCase.call(params: event.expenseId);
    add(GetAllUserExpense(
      userId: event.userId
    ));
  }

  //Todo: create CopyWith() method
  FutureOr<void> _onToggleShowExpense(ToggleShowExpense event, Emitter<ManageMoneyState> emit) {
    emit(ManageMoneyState._(
      showExpense: event.showExpense,
      showIncome: state.showIncome,
      listUserExpense: state.listUserExpense,
      totalExpense: state.totalExpense,
      totalIncome: state.totalIncome,
      status: ManageMoneyStatus.success
    ));
  }

  FutureOr<void> _onToggleShowIncome(ToggleShowIncome event, Emitter<ManageMoneyState> emit) {
    emit(ManageMoneyState._(
      showIncome: event.showIncome,
      showExpense: state.showExpense,
        listUserExpense: state.listUserExpense,
        totalExpense: state.totalExpense,
        totalIncome: state.totalIncome,
        status: ManageMoneyStatus.success
    ));
  }
}
