import 'package:dartz/dartz.dart';
import '../../core/params/add_note_param.dart';
import '../entities/note.dart';

abstract class INoteRepository {
  Future<Either<Exception, List<Note>>> getNotes();
  Future<Either<Exception, void>> addNotes(AddNoteParams? note);
}