import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:just_notes/domain/entities/user_expense.dart';
import 'package:just_notes/domain/usecases/expense_usecase/get_expenses_usecase.dart';

part 'manage_money_event.dart';
part 'manage_money_state.dart';

@injectable
class ManageMoneyBloc extends Bloc<ManageMoneyEvent, ManageMoneyState> {

  final GetExpenseUseCase _getUserExpenseUseCase;

  ManageMoneyBloc(this._getUserExpenseUseCase) : super(const ManageMoneyState.initial()) {
    on<GetAllUserExpense>(_onGetAllUserExpense);
  }

  FutureOr<void> _onGetAllUserExpense(GetAllUserExpense event, Emitter<ManageMoneyState> emit) async {
    emit(const ManageMoneyState.loading());
    final response = await _getUserExpenseUseCase.call();
    response.fold(
            (l) => emit(ManageMoneyState.failure(errorMessage: l.toString())),
            (r) => emit(ManageMoneyState.success(listUserExpense: r))
    );
  }
}
