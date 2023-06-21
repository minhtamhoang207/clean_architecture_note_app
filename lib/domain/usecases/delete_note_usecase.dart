import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:just_notes/domain/repositories/i_note_repository.dart';
import '../../core/usecase/usecase.dart';

@lazySingleton
class DeleteNoteUseCase extends UseCase<void, int> {
  DeleteNoteUseCase(this.repository);

  final INoteRepository repository;

  @override
  Future<Either<Exception, void>> call({required int params}) {
    return repository.deleteNote(noteID: params);
  }
}
