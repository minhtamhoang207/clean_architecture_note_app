import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:just_notes/core/params/add_note_param.dart';
import 'package:just_notes/domain/usecases/note_usecases/add_note_usecase.dart';
import 'package:just_notes/domain/usecases/note_usecases/update_note_usecase.dart';

part 'add_note_event.dart';
part 'add_note_state.dart';

@injectable
class AddNoteBloc extends Bloc<AddNoteEvent, AddNoteState> {

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  final AddNotesUseCase _addNotesUseCase;
  final UpdateNotesUseCase _updateNotesUseCase;

  AddNoteBloc(this._addNotesUseCase, this._updateNotesUseCase) : super(const AddNoteState.initial()) {
    on<ToggleImportant>(_onToggleImportant);
    on<SaveNote>(_onSaveNote);
  }

  FutureOr<void> _onToggleImportant(ToggleImportant event, Emitter<AddNoteState> emit) async {
    emit(AddNoteState._(isImportant: event.isImportant));
  }

  FutureOr<void> _onSaveNote(SaveNote event, Emitter<AddNoteState> emit) async {
    if (titleController.text.trim().isNotEmpty
        || contentController.text.trim().isNotEmpty) {
      final response = event.isUpdate
        ? await _updateNotesUseCase.call(params: event.addNoteParams)
        : await _addNotesUseCase.call(params: event.addNoteParams);
      response.fold(
        (l) => emit(AddNoteState.failure(errorMessage: l.toString())),
        (r) => emit(const AddNoteState.success())
      );
    } else {
      emit(const AddNoteState.empty());
    }
  }
}
