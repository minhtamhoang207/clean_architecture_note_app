part of 'add_friend_bloc.dart';

abstract class AddFriendEvent extends Equatable {
  const AddFriendEvent();
}

class ConfirmAddFriend extends AddFriendEvent {
  const ConfirmAddFriend({required this.userModel});

  final UserModel userModel;

  @override
  List<Object?> get props => [userModel];
}