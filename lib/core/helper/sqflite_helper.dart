import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  static const _databaseName = 'just_notes.db';
  static const _databaseVersion = 1;

  static const tableUser = 'User';
  static const tableNote = 'Note';
  static const tableExpense = 'Expense';

  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnContent = 'content';
  static const columnImportant = 'important';
  static const columnCreateAt = 'create_at';
  static const columnUserId = 'user_id';
  static const columnName = 'name';
  static const columnAvatar = 'avatar';
  static const columnAmount = 'amount';
  static const columnNote = 'note';

  LocalDatabase._privateConstructor();
  static final LocalDatabase instance = LocalDatabase._privateConstructor();

  late final Database _database;

  Future<Database> get database async {
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = '${documentsDirectory.path}$_databaseName';
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $tableNote (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnTitle TEXT,
            $columnContent TEXT,
            $columnImportant INTEGER,
            $columnCreateAt INTEGER,
            $columnUserId INTEGER,
            FOREIGN KEY ($columnUserId) REFERENCES User($columnId)
           )
        ''');

    await db.execute('''
        CREATE TABLE User (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT,
            $columnAvatar TEXT,
            $columnCreateAt INTEGER
        )
    ''');

    await db.execute('''
        CREATE TABLE Expense (
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnAmount INTEGER,
          $columnCreateAt INTEGER,
          $columnNote TEXT,
          $columnUserId INTEGER,
          FOREIGN KEY ($columnUserId) REFERENCES User($columnId)
        )
        ''');
  }
}
