part of 'add_note_bloc.dart';

abstract class AddNoteEvent extends Equatable {
  const AddNoteEvent();
}

class SaveNote extends AddNoteEvent {
  const SaveNote({required this.addNoteParams, this.isUpdate = false});

  final AddNoteParams addNoteParams;
  final bool isUpdate;

  @override
  List<Object?> get props => [addNoteParams, isUpdate];
}

class ToggleImportant extends AddNoteEvent {
  const ToggleImportant({required this.isImportant});

  final bool isImportant;

  @override
  List<Object?> get props => [isImportant];
}