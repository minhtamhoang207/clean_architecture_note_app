// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i7;
import 'package:sqflite/sqflite.dart' as _i3;

import '../../data/datasources/local/local.dart' as _i5;
import '../../data/datasources/remote/auth_service.dart' as _i9;
import '../../data/repositories/auth_repository.dart' as _i11;
import '../../data/repositories/note_repository.dart' as _i13;
import '../../domain/repositories/i_auth_repository.dart' as _i10;
import '../../domain/repositories/i_note_repository.dart' as _i12;
import '../../domain/usecases/add_note_usecase.dart' as _i14;
import '../../domain/usecases/auth_usecase.dart' as _i15;
import '../../domain/usecases/delete_note_usecase.dart' as _i16;
import '../../domain/usecases/get_note_usecase.dart' as _i17;
import '../../presentation/home_page/home_page_provider.dart' as _i18;
import '../network/interceptor.dart' as _i6;
import '../network/network_info.dart' as _i8;
import 'register_module.dart' as _i19; // ignore_for_file: unnecessary_lambdas

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
  await gh.lazySingletonAsync<_i4.Dio>(
    () => registerModule.dio,
    preResolve: true,
  );
  gh.lazySingleton<_i5.IHomeLocalDataSource>(
      () => _i5.HomeLocalDataSource(get<_i3.Database>()));
  gh.lazySingleton<_i4.Interceptor>(() => _i6.AppInterceptors());
  gh.lazySingleton<_i7.InternetConnectionChecker>(
      () => registerModule.connectionChecker);
  gh.lazySingleton<_i8.NetworkInfo>(
      () => _i8.NetworkInfo(get<_i7.InternetConnectionChecker>()));
  gh.lazySingleton<_i9.AuthService>(() => _i9.AuthService(get<_i4.Dio>()));
  gh.lazySingleton<_i10.IAuthRepository>(() => _i11.AuthRepository(
        get<_i8.NetworkInfo>(),
        get<_i9.AuthService>(),
      ));
  gh.lazySingleton<_i12.INoteRepository>(() => _i13.HomeRepository(
        get<_i8.NetworkInfo>(),
        get<_i5.IHomeLocalDataSource>(),
      ));
  gh.lazySingleton<_i14.AddNotesUseCase>(
      () => _i14.AddNotesUseCase(get<_i12.INoteRepository>()));
  gh.lazySingleton<_i15.AuthUseCase>(
      () => _i15.AuthUseCase(get<_i10.IAuthRepository>()));
  gh.lazySingleton<_i16.DeleteNoteUseCase>(
      () => _i16.DeleteNoteUseCase(get<_i12.INoteRepository>()));
  gh.lazySingleton<_i17.GetNotesUseCase>(
      () => _i17.GetNotesUseCase(get<_i12.INoteRepository>()));
  gh.lazySingleton<_i18.HomePageProvider>(() => _i18.HomePageProvider(
        get<_i14.AddNotesUseCase>(),
        get<_i17.GetNotesUseCase>(),
        get<_i16.DeleteNoteUseCase>(),
      ));
  return get;
}

class _$RegisterModule extends _i19.RegisterModule {}
