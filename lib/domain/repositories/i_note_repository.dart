import 'package:dartz/dartz.dart';
import 'package:just_notes/data/models/user_model.dart';
import 'package:just_notes/domain/entities/user.dart';
import '../../core/params/add_note_param.dart';
import '../entities/note.dart';

abstract class INoteRepository {
  Future<Either<Exception, List<Note>>> getNotes();
  Future<Either<Exception, void>> addNotes({required AddNoteParams note});
  Future<Either<Exception, void>> deleteNote({required int noteID});
  Future<Either<Exception, void>> updateNote({required AddNoteParams note});

  Future<Either<Exception, List<User>>> getFriends();
  Future<Either<Exception, void>> addFriend({required UserModel param});
  Future<Either<Exception, void>> deleteFriend({required int friendID});
}
