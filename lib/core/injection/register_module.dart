import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:just_notes/core/helper/sqflite_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sqflite/sqflite.dart';

import '../helper/interceptor.dart';
import '../util/constants.dart';

@module
abstract class RegisterModule {
  // @lazySingleton
  // InternetConnectionChecker get connectionChecker =>
  //     InternetConnectionChecker();

  @preResolve
  @lazySingleton
  Future<Database> get database async {
    return LocalDatabase.instance.database;
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
