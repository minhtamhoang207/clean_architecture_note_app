import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:just_notes/domain/entities/note.dart';
import 'package:just_notes/domain/usecases/note_usecases/delete_note_usecase.dart';
import 'package:just_notes/domain/usecases/note_usecases/get_note_usecase.dart';

part 'note_event.dart';
part 'note_state.dart';

@lazySingleton
class NoteBloc extends Bloc<NoteEvent, NoteState> {

  final GetNotesUseCase _getNotesUseCase;
  final DeleteNoteUseCase _deleteNoteUseCase;

  NoteBloc(this._getNotesUseCase, this._deleteNoteUseCase) : super(NoteInitial()) {
    on<GetAllNoteEvent>(_onGetAllNote);
    on<DeleteNote>(_onDeleteNote);
    on<ChangeOverlayStatus>(_onChangeOverlayStatus);
  }

  FutureOr<void> _onGetAllNote(GetAllNoteEvent event, Emitter<NoteState> emit) async {
    emit(LoadingNote());
    final response = await _getNotesUseCase.call();
    response.fold(
      (l) => emit(const LoadNoteFailed()),
      (r) => emit(LoadNoteSuccess(listNote: r))
    );
  }

  FutureOr<void> _onDeleteNote(DeleteNote event, Emitter<NoteState> emit) async {
    await _deleteNoteUseCase.call(params: event.noteId);
    add(GetAllNoteEvent());
  }

  FutureOr<void> _onChangeOverlayStatus(ChangeOverlayStatus event, Emitter<NoteState> emit) {
    emit(LoadNoteSuccess(listNote: event.listNote, showOverlay: event.showOverlay));
  }
}
