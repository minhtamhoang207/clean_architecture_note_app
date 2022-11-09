import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  InternetConnectionChecker get connectionChecker =>
      InternetConnectionChecker();

  @preResolve
  @lazySingleton
  Future<Database> get database async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = '${documentsDirectory.path}just_notes.db';
    return await openDatabase(path, version: 1,
        onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE Notes ("
              "id INTEGER PRIMARY KEY,"
              "title TEXT,"
              "content TEXT"
              ")");
        },
    );
  }
}