import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:just_notes/core/usecase/usecase.dart';
import 'package:just_notes/domain/entities/user.dart';
import 'package:just_notes/domain/repositories/i_note_repository.dart';

@lazySingleton
class GetFriendsUseCase extends UseCase<List<User>, void> {
  GetFriendsUseCase(this.repository);

  final INoteRepository repository;

  @override
  Future<Either<Exception, List<User>>> call({void params}) {
    return repository.getFriends();
  }
}