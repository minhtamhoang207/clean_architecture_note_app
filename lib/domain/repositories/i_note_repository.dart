import 'package:dartz/dartz.dart';
import 'package:just_notes/data/models/expense_model.dart';
import 'package:just_notes/data/models/user_model.dart';
import 'package:just_notes/domain/entities/user.dart';
import '../../core/params/add_note_param.dart';
import '../entities/note.dart';
import '../entities/user_expense.dart';

abstract class INoteRepository {
  Future<Either<Exception, List<Note>>> getNotes();
  Future<Either<Exception, void>> addNotes({required AddNoteParams note});
  Future<Either<Exception, void>> deleteNote({required int noteID});
  Future<Either<Exception, void>> updateNote({required AddNoteParams note});

  Future<Either<Exception, List<User>>> getFriends();
  Future<Either<Exception, void>> addFriend({required UserModel param});
  Future<Either<Exception, void>> deleteFriend({required int friendID});

  Future<Either<Exception, List<UserExpense>>> getAllExpense();
  Future<Either<Exception, void>> addExpense({required ExpenseModel param});
  Future<Either<Exception, void>> deleteExpense({required int expenseId});
}
