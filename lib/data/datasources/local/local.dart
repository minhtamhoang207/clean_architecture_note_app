import 'package:injectable/injectable.dart';
import 'package:just_notes/data/models/note_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/params/add_note_param.dart';

abstract class IHomeLocalDataSource {
  Future<List<NoteModel>> getNotes();
  Future<void> addNote(AddNoteParams? addNoteParams);
  Future<void> deleteNote(int noteID);
}


@LazySingleton(as: IHomeLocalDataSource)
class HomeLocalDataSource implements IHomeLocalDataSource {
  HomeLocalDataSource(this._database);

  final Database _database;

  @override
  Future<List<NoteModel>> getNotes() async {
    List<Map<String, dynamic>> maps = await _database.query('Notes',
        columns: ['id', 'title', 'content', 'important', 'create_at']
    );
    List<NoteModel> listNote = List.generate(
        maps.length,
        (index) => NoteModel.fromJson(maps[index]),
        growable: true
    );
    return listNote;
  }

  @override
  Future<void> addNote(AddNoteParams? params) async {
    if(params != null){
      await _database.insert('Notes', params.toMap());
    }
  }

  @override
  Future<void> deleteNote(int noteID) async {
    await _database.delete('Notes', where: 'id = ?', whereArgs: [noteID]);
  }
  // bool _isFirstPage(int page) => page == 1;
}