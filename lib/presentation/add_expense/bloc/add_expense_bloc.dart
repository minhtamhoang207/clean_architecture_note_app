import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:just_notes/data/models/expense_model.dart';
import 'package:just_notes/domain/entities/user.dart';

import '../../../domain/usecases/expense_usecase/add_expense_usecase.dart';
import '../../../domain/usecases/friend_usecases/get_friends_usecase.dart';

part 'add_expense_event.dart';
part 'add_expense_state.dart';

@injectable
class AddExpenseBloc extends Bloc<AddExpenseEvent, AddExpenseState> {

  final GetFriendsUseCase _getFriendsUseCase;
  final AddExpenseUseCase _addExpenseUseCase;

  AddExpenseBloc(this._getFriendsUseCase, this._addExpenseUseCase)
      : super(const AddExpenseState.initial()) {
    on<GetAllFriend>(_onGetAllFriend);
    on<ConfirmAddExpense>(_onConfirmAddExpense);
  }

  FutureOr<void> _onGetAllFriend(GetAllFriend event, Emitter<AddExpenseState> emit) async {
    emit(const AddExpenseState.loading());
    final response = await _getFriendsUseCase.call();
    response.fold(
            (l) => emit(AddExpenseState.failure(errorMessage: l.toString())),
            (r) => emit(AddExpenseState.success(listFriend: r))
    );
  }

  FutureOr<void> _onConfirmAddExpense(ConfirmAddExpense event, Emitter<AddExpenseState> emit) async {
    final response = await _addExpenseUseCase.call(params: event.expenseModel);
    response.fold(
            (l) => emit(AddExpenseState.failure(errorMessage: l.toString())),
            (r) => emit(AddExpenseState.success(listFriend: state.listFriend))
    );
  }
}
