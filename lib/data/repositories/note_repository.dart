import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:just_notes/data/models/note_model.dart';
import 'package:just_notes/domain/entities/note.dart';
import 'package:just_notes/domain/repositories/i_note_repository.dart';

import '../../core/network/network_info.dart';
import '../../core/params/add_note_param.dart';
import '../datasources/local/local.dart';

@LazySingleton(as: INoteRepository)
class HomeRepository implements INoteRepository {
  HomeRepository(this._networkInfo, this._localDataSource);

  final IHomeLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<Exception, List<Note>>> getNotes() async {
    if (await _networkInfo.isConnected) {
      try {
        final List<NoteModel> models = await _localDataSource.getNotes();
        final entities = models.map<Note>((e) => e.toEntity()).toList();
        return Right(entities);
      } catch (e) {
        return Left(Exception(e));
      }
    } else {
      return const Left(SocketException(''));
    }
  }

  @override
  Future<Either<Exception, void>> addNotes(
      {required AddNoteParams note}) async {
    if (await _networkInfo.isConnected) {
      try {
        await _localDataSource.addNote(note);
        return const Right(null);
      } catch (e) {
        return Left(Exception(e));
      }
    } else {
      return const Left(SocketException(''));
    }
  }

  @override
  Future<Either<Exception, void>> deleteNote({required int noteID}) async {
    if (await _networkInfo.isConnected) {
      try {
        await _localDataSource.deleteNote(noteID);
        return const Right(null);
      } catch (e) {
        return Left(Exception(e));
      }
    } else {
      return const Left(SocketException(''));
    }
  }
}
