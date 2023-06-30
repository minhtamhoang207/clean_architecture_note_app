import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:just_notes/data/models/user_model.dart';
import 'package:just_notes/domain/usecases/friend_usecases/add_friend_usecase.dart';

part 'add_friend_event.dart';
part 'add_friend_state.dart';

@injectable
class AddFriendBloc extends Bloc<AddFriendEvent, AddFriendState> {

  final AddFriendUseCase _addFriendUseCase;

  AddFriendBloc(this._addFriendUseCase) : super(const AddFriendState.initial()) {
    on<ConfirmAddFriend>(_onConfirmAddFriend);
    on<PickAvatar>(_onPickAvatar);
  }

  FutureOr<void> _onConfirmAddFriend(ConfirmAddFriend event, Emitter<AddFriendState> emit) async {
    emit(const AddFriendState.loading());
    final response = await _addFriendUseCase.call(params: event.userModel);
    response.fold(
            (l) => emit(const AddFriendState.failure()),
            (r) => emit(const AddFriendState.success())
    );
  }

  FutureOr<void> _onPickAvatar(PickAvatar event, Emitter<AddFriendState> emit) {
    emit(AddFriendState._(
      avatar: event.avatar
    ));
  }
}
