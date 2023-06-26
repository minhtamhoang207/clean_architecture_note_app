import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:just_notes/domain/repositories/i_note_repository.dart';
import '../../../core/usecase/usecase.dart';

@lazySingleton
class DeleteFriendUseCase extends UseCase<void, int> {
  DeleteFriendUseCase(this.repository);

  final INoteRepository repository;

  @override
  Future<Either<Exception, void>> call({required int params}) {
    return repository.deleteFriend(friendID: params);
  }
}
