import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:just_notes/domain/repositories/i_note_repository.dart';

import '../../core/params/add_note_param.dart';
import '../../core/usecase/usecase.dart';

@lazySingleton
class AddNotesUseCase extends UseCase<void, AddNoteParams> {
  AddNotesUseCase(this.repository);

  final INoteRepository repository;

  @override
  Future<Either<Exception, void>> call({required AddNoteParams params}) {
    return repository.addNotes(note: params);
  }
}
