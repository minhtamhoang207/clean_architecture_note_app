import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:just_notes/core/usecase/usecase.dart';
import 'package:just_notes/data/models/user_model.dart';
import 'package:just_notes/domain/repositories/i_note_repository.dart';

@lazySingleton
class AddFriendUseCase extends UseCase<void, UserModel> {
  AddFriendUseCase(this.repository);

  final INoteRepository repository;

  @override
  Future<Either<Exception, void>> call({required UserModel params}) {
    return repository.addFriend(param: params);
  }
}
