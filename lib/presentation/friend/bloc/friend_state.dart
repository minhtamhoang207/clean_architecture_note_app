part of 'friend_bloc.dart';

enum GetFriendStatus { initial, loading, success, failure, empty }

class FriendState extends Equatable {
  const FriendState._(
      {this.status = GetFriendStatus.initial,
        this.listFriend = const [],
        this.errorMessage});

  final GetFriendStatus status;
  final List<User> listFriend;
  final String? errorMessage;

  const FriendState.initial() : this._();

  const FriendState.loading() : this._(status: GetFriendStatus.loading);

  const FriendState.success({required List<User> listUser}) : this._(
    status: GetFriendStatus.success,
    listFriend: listUser
  );

  const FriendState.empty() : this._(status: GetFriendStatus.empty);

  const FriendState.failure({String? errorMessage})
      : this._(status: GetFriendStatus.failure, errorMessage: errorMessage);

  @override
  List<Object?> get props => [status, listFriend, errorMessage];
}
