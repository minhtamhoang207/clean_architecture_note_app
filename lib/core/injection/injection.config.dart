// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:just_notes/core/helper/interceptor.dart' as _i8;
import 'package:just_notes/core/injection/register_module.dart' as _i23;
import 'package:just_notes/data/datasources/local/local.dart' as _i5;
import 'package:just_notes/data/datasources/remote/auth_service.dart' as _i12;
import 'package:just_notes/data/repositories/auth_repository.dart' as _i18;
import 'package:just_notes/data/repositories/note_repository.dart' as _i7;
import 'package:just_notes/domain/repositories/i_auth_repository.dart' as _i17;
import 'package:just_notes/domain/repositories/i_note_repository.dart' as _i6;
import 'package:just_notes/domain/usecases/auth_usecase.dart' as _i21;
import 'package:just_notes/domain/usecases/friend_usecases/add_friend_usecase.dart'
    as _i10;
import 'package:just_notes/domain/usecases/friend_usecases/delete_friend_usecase.dart'
    as _i13;
import 'package:just_notes/domain/usecases/friend_usecases/get_friends_usecase.dart'
    as _i15;
import 'package:just_notes/domain/usecases/note_usecases/add_note_usecase.dart'
    as _i11;
import 'package:just_notes/domain/usecases/note_usecases/delete_note_usecase.dart'
    as _i14;
import 'package:just_notes/domain/usecases/note_usecases/get_note_usecase.dart'
    as _i16;
import 'package:just_notes/domain/usecases/note_usecases/update_note_usecase.dart'
    as _i9;
import 'package:just_notes/presentation/add_note/bloc/add_note_bloc.dart'
    as _i20;
import 'package:just_notes/presentation/friend/bloc/friend_bloc.dart' as _i22;
import 'package:just_notes/presentation/note/bloc/note_bloc.dart' as _i19;
import 'package:sqflite/sqflite.dart' as _i3;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
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
        () => _i5.HomeLocalDataSource(gh<_i3.Database>()));
    gh.lazySingleton<_i6.INoteRepository>(
        () => _i7.HomeRepository(gh<_i5.IHomeLocalDataSource>()));
    gh.lazySingleton<_i4.Interceptor>(() => _i8.AppInterceptors());
    gh.lazySingleton<_i9.UpdateNotesUseCase>(
        () => _i9.UpdateNotesUseCase(gh<_i6.INoteRepository>()));
    gh.lazySingleton<_i10.AddFriendUseCase>(
        () => _i10.AddFriendUseCase(gh<_i6.INoteRepository>()));
    gh.lazySingleton<_i11.AddNotesUseCase>(
        () => _i11.AddNotesUseCase(gh<_i6.INoteRepository>()));
    gh.lazySingleton<_i12.AuthService>(() => _i12.AuthService(gh<_i4.Dio>()));
    gh.lazySingleton<_i13.DeleteFriendUseCase>(
        () => _i13.DeleteFriendUseCase(gh<_i6.INoteRepository>()));
    gh.lazySingleton<_i14.DeleteNoteUseCase>(
        () => _i14.DeleteNoteUseCase(gh<_i6.INoteRepository>()));
    gh.lazySingleton<_i15.GetFriendsUseCase>(
        () => _i15.GetFriendsUseCase(gh<_i6.INoteRepository>()));
    gh.lazySingleton<_i16.GetNotesUseCase>(
        () => _i16.GetNotesUseCase(gh<_i6.INoteRepository>()));
    gh.lazySingleton<_i17.IAuthRepository>(
        () => _i18.AuthRepository(gh<_i12.AuthService>()));
    gh.lazySingleton<_i19.NoteBloc>(() => _i19.NoteBloc(
          gh<_i16.GetNotesUseCase>(),
          gh<_i14.DeleteNoteUseCase>(),
        ));
    gh.factory<_i20.AddNoteBloc>(() => _i20.AddNoteBloc(
          gh<_i11.AddNotesUseCase>(),
          gh<_i9.UpdateNotesUseCase>(),
        ));
    gh.lazySingleton<_i21.AuthUseCase>(
        () => _i21.AuthUseCase(gh<_i17.IAuthRepository>()));
    gh.factory<_i22.FriendBloc>(
        () => _i22.FriendBloc(gh<_i15.GetFriendsUseCase>()));
    return this;
  }
}

class _$RegisterModule extends _i23.RegisterModule {}
