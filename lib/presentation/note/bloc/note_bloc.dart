import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_notes/core/injection/injection.dart';
import 'package:just_notes/domain/entities/note.dart';
import 'package:just_notes/domain/usecases/get_note_usecase.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {

  final GetNotesUseCase _getNotesUseCase = getIt();

  NoteBloc() : super(NoteInitial()) {
    on<GetAllNoteEvent>(_onGetAllNote);
  }

  FutureOr<void> _onGetAllNote(GetAllNoteEvent event, Emitter<NoteState> emit) async {
    emit(LoadingNote());
    await Future.delayed(const Duration(seconds: 3));
    final response = await _getNotesUseCase.call();
    response.fold(
      (l) => emit(const LoadNoteFailed()),
      (r) => emit(LoadNoteSuccess(listNote: r))
    );
  }
}
