// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i7;
import 'package:sqflite/sqflite.dart' as _i3;

import '../../data/datasources/local.dart' as _i4;
import '../../data/repositories/note_repository.dart' as _i10;
import '../../domain/repositories/i_note_repository.dart' as _i9;
import '../../domain/usecases/add_note_usecase.dart' as _i11;
import '../../domain/usecases/get_note_usecase.dart' as _i12;
import '../network/network_info.dart' as _i8;
import '../network/rest_client.dart' as _i6;
import 'register_module.dart' as _i13; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  await gh.lazySingletonAsync<_i3.Database>(
    () => registerModule.database,
    preResolve: true,
  );
  gh.lazySingleton<_i4.IHomeLocalDataSource>(
      () => _i4.HomeLocalDataSource(get<_i3.Database>()));
  gh.lazySingleton<_i5.Interceptor>(() => _i6.AppInterceptors());
  gh.lazySingleton<_i7.InternetConnectionChecker>(
      () => registerModule.connectionChecker);
  gh.lazySingleton<_i8.NetworkInfo>(
      () => _i8.NetworkInfo(get<_i7.InternetConnectionChecker>()));
  gh.lazySingleton<_i6.RestClient>(() => _i6.RestClient());
  gh.lazySingleton<_i9.INoteRepository>(() => _i10.HomeRepository(
        get<_i8.NetworkInfo>(),
        get<_i4.IHomeLocalDataSource>(),
      ));
  gh.lazySingleton<_i11.AddNotesUseCase>(
      () => _i11.AddNotesUseCase(get<_i9.INoteRepository>()));
  gh.lazySingleton<_i12.GetNotesUseCase>(
      () => _i12.GetNotesUseCase(get<_i9.INoteRepository>()));
  return get;
}

class _$RegisterModule extends _i13.RegisterModule {}
