import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:just_notes/domain/entities/user.dart';
import 'package:just_notes/domain/usecases/friend_usecases/delete_friend_usecase.dart';
import 'package:just_notes/domain/usecases/friend_usecases/get_friends_usecase.dart';

part 'friend_event.dart';
part 'friend_state.dart';

@injectable
class FriendBloc extends Bloc<FriendEvent, FriendState> {

  final GetFriendsUseCase _getFriendsUseCase;
  final DeleteFriendUseCase _deleteFriendUseCase;

  FriendBloc(this._getFriendsUseCase, this._deleteFriendUseCase)
      : super(const FriendState.initial()) {
    on<GetAllFriend>(_onGetAllFriend);
    on<DeleteFriend>(_onDeleteFriend);
  }

  FutureOr<void> _onGetAllFriend(GetAllFriend event, Emitter<FriendState> emit) async {
    emit(const FriendState.loading());
    final response = await _getFriendsUseCase.call();
    response.fold(
      (l) => emit(FriendState.failure(errorMessage: l.toString())),
      (r) => emit(FriendState.success(listUser: r))
    );
  }

  FutureOr<void> _onDeleteFriend(DeleteFriend event, Emitter<FriendState> emit) async {
    emit(const FriendState.loading());
    final response = await _deleteFriendUseCase.call(params: event.friendId);
    response.fold(
            (l) => emit(FriendState.failure(errorMessage: l.toString())),
            (r) => add(GetAllFriend())
    );
  }
}
