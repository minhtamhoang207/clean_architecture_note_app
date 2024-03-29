import 'package:injectable/injectable.dart';
import 'package:just_notes/core/helper/sqflite_helper.dart';
import 'package:just_notes/data/models/note_model.dart';
import 'package:just_notes/data/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/params/add_note_param.dart';

abstract class IHomeLocalDataSource {
  Future<List<NoteModel>> getNotes();
  Future<void> addNote(AddNoteParams? addNoteParams);
  Future<void> deleteNote(int noteID);
  Future<void> updateNote(AddNoteParams? addNoteParams);

  Future<List<UserModel>> getFriends();
  Future<void> addFriend(UserModel? addFiendParams);
  Future<void> deleteFriend(int friendID);
}

@LazySingleton(as: IHomeLocalDataSource)
class HomeLocalDataSource implements IHomeLocalDataSource {
  HomeLocalDataSource(this._database);

  final Database _database;

  @override
  Future<List<NoteModel>> getNotes() async {
    List<Map<String, dynamic>> maps =
        await _database.query(LocalDatabase.tableNote,
            columns: [
              LocalDatabase.columnId,
              LocalDatabase.columnUserId,
              LocalDatabase.columnTitle,
              LocalDatabase.columnContent,
              LocalDatabase.columnImportant,
              LocalDatabase.columnCreateAt,
              LocalDatabase.columnTitle,
            ],
            orderBy: '${LocalDatabase.columnCreateAt} DESC');
    List<NoteModel> listNote = List.generate(
        maps.length, (index) => NoteModel.fromJson(maps[index]),
        growable: true);
    return listNote;
  }

  @override
  Future<void> addNote(AddNoteParams? params) async {
    if (params != null) {
      await _database.insert(LocalDatabase.tableNote, params.toMap());
    }
  }

  @override
  Future<void> deleteNote(int noteID) async {
    await _database.delete(LocalDatabase.tableNote,
        where: '${LocalDatabase.columnId} = ?', whereArgs: [noteID]);
  }

  @override
  Future<void> addFriend(UserModel? params) async {
    if (params != null) {
      await _database.insert(LocalDatabase.tableUser, params.toJson());
    }
  }

  @override
  Future<void> deleteFriend(int friendID) async {
    await _database.delete(LocalDatabase.tableUser,
        where: '${LocalDatabase.columnId} = ?', whereArgs: [friendID]);
  }

  @override
  Future<List<UserModel>> getFriends() async {
    List<Map<String, dynamic>> maps =
        await _database.query(LocalDatabase.tableUser,
            columns: [
              LocalDatabase.columnId,
              LocalDatabase.columnName,
              LocalDatabase.columnAvatar,
              LocalDatabase.columnCreateAt,
            ],
            orderBy: '${LocalDatabase.columnCreateAt} DESC');
    List<UserModel> listFriend = List.generate(
        maps.length, (index) => UserModel.fromJson(maps[index]),
        growable: true);
    return listFriend;
  }

  @override
  Future<void> updateNote(AddNoteParams? addNoteParams) async {
    if (addNoteParams != null) {
      await _database.update(LocalDatabase.tableNote, addNoteParams.toMap(),
          where: '${LocalDatabase.columnId} = ?',
          whereArgs: [addNoteParams.id]);
    }
  }
}
