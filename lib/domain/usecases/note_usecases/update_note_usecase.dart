import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:just_notes/core/params/add_note_param.dart';
import 'package:just_notes/core/usecase/usecase.dart';
import 'package:just_notes/domain/repositories/i_note_repository.dart';

@lazySingleton
class UpdateNotesUseCase extends UseCase<void, AddNoteParams> {
  UpdateNotesUseCase(this.repository);

  final INoteRepository repository;

  @override
  Future<Either<Exception, void>> call({required AddNoteParams params}) {
    return repository.updateNote(note: params);
  }
}
