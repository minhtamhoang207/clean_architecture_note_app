part of 'add_friend_bloc.dart';

enum AddFriendStatus { initial, loading, success, failure, empty }

class AddFriendState extends Equatable {
  const AddFriendState._({
    this.addFriendStatus = AddFriendStatus.initial,
    this.errorMessage,
    this.avatar
  });

  final String? errorMessage;
  final AddFriendStatus addFriendStatus;
  final File? avatar;

  const AddFriendState.initial() : this._();

  const AddFriendState.loading()
      : this._(addFriendStatus: AddFriendStatus.loading);

  const AddFriendState.success()
      : this._(addFriendStatus: AddFriendStatus.success);

  const AddFriendState.failure({String? errorMessage})
      : this._(
          errorMessage: errorMessage,
          addFriendStatus: AddFriendStatus.failure
        );

  const AddFriendState.empty() : this._();

  @override
  List<Object?> get props => [errorMessage, addFriendStatus];
}