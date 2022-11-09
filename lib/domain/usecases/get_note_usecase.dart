import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:just_notes/data/models/note_model.dart';
import 'package:just_notes/domain/entities/note.dart';
import 'package:just_notes/domain/repositories/i_note_repository.dart';

import '../../core/usecase/usecase.dart';

@lazySingleton
class GetNotesUseCase extends UseCase<List<Note>, void> {
  GetNotesUseCase(this.repository);

  final INoteRepository repository;

  @override
  Future<Either<Exception, List<Note>>> call({void params}) {
    return repository.getNotes();
  }
}

class NoteParams {
  NoteParams(this.page);

  final int page;
}