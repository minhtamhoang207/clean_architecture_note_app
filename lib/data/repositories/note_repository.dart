import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:just_notes/data/models/expense_model.dart';
import 'package:just_notes/data/models/note_model.dart';
import 'package:just_notes/data/models/user_expense_model.dart';
import 'package:just_notes/data/models/user_model.dart';
import 'package:just_notes/domain/entities/note.dart';
import 'package:just_notes/domain/entities/user.dart';
import 'package:just_notes/domain/entities/user_expense.dart';
import 'package:just_notes/domain/repositories/i_note_repository.dart';
import '../../core/params/add_note_param.dart';
import '../datasources/local/local.dart';

@LazySingleton(as: INoteRepository)
class HomeRepository implements INoteRepository {
  HomeRepository(this._localDataSource);

  final IHomeLocalDataSource _localDataSource;

  @override
  Future<Either<Exception, List<Note>>> getNotes() async {
    try {
      final List<NoteModel> models = await _localDataSource.getNotes();
      final entities = models.map<Note>((e) => e.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> addNotes(
      {required AddNoteParams note}) async {
    try {
      await _localDataSource.addNote(note);
      return const Right(null);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> deleteNote({required int noteID}) async {
    try {
      await _localDataSource.deleteNote(noteID);
      return const Right(null);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> addFriend({required UserModel param}) async {
    try {
      await _localDataSource.addFriend(param);
      return const Right(null);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> deleteFriend({required int friendID}) async {
    try {
      await _localDataSource.deleteFriend(friendID);
      return const Right(null);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, List<User>>> getFriends() async {
    try {
      final List<UserModel> models = await _localDataSource.getFriends();
      final entities = models.map<User>((e) => e.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> updateNote(
      {required AddNoteParams note}) async {
    try {
      await _localDataSource.updateNote(note);
      return const Right(null);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, List<UserExpense>>> getAllExpense() async {
    try {
      final List<UserExpenseModel> models = await _localDataSource.getAllExpense();
      final entities = models.map<UserExpense>((e) => e.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> addExpense({required ExpenseModel param}) async {
    try {
      await _localDataSource.addExpense(expenseParams: param);
      return const Right(null);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
