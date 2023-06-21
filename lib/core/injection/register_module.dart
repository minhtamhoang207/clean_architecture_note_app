import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sqflite/sqflite.dart';

import '../network/interceptor.dart';
import '../util/constants.dart';

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
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE Notes ("
            "id INTEGER PRIMARY KEY,"
            "title TEXT,"
            "content TEXT,"
            "important INTEGER,"
            "create_at INTEGER"
            ")");
      },
    );
  }

  @preResolve
  @lazySingleton
  Future<Dio> get dio async {
    final dio = Dio()..options = BaseOptions(baseUrl: Constants.baseUrl);
    dio.interceptors.addAll([
      AppInterceptors(),
      PrettyDioLogger(
          requestHeader: false,
          responseHeader: false,
          requestBody: true,
          responseBody: true,
          error: true,
          compact: true,
          maxWidth: 90)
    ]);
    return dio;
  }
}
