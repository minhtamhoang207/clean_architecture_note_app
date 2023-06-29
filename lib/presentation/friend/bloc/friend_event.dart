part of 'friend_bloc.dart';

abstract class FriendEvent extends Equatable {
  const FriendEvent();
}

class GetAllFriend extends FriendEvent {
  @override
  List<Object?> get props => [];
}

class DeleteFriend extends FriendEvent {
  const DeleteFriend({required this.friendId});

  final int friendId;

  @override
  List<Object?> get props => [friendId];
}