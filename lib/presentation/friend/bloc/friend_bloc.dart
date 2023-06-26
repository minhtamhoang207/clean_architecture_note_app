import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:just_notes/domain/entities/user.dart';
import 'package:just_notes/domain/usecases/friend_usecases/get_friends_usecase.dart';

part 'friend_event.dart';
part 'friend_state.dart';

@injectable
class FriendBloc extends Bloc<FriendEvent, FriendState> {

  final GetFriendsUseCase _getFriendsUseCase;

  FriendBloc(this._getFriendsUseCase) : super(const FriendState.initial()) {
    on<GetAllFriend>(_onGetAllFriend);
  }

  FutureOr<void> _onGetAllFriend(GetAllFriend event, Emitter<FriendState> emit) async {
    emit(const FriendState.loading());
    final response = await _getFriendsUseCase.call();
    await Future.delayed(Duration(seconds: 20));
    response.fold(
      (l) => emit(FriendState.failure(errorMessage: l.toString())),
      (r) => emit(FriendState.success(listUser: r))
    );
  }
}
