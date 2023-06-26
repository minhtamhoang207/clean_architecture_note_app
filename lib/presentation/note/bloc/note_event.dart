part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();
}

class GetAllNoteEvent extends NoteEvent {
  @override
  List<Object?> get props => [];
}

class ChangeOverlayStatus extends NoteEvent {
  const ChangeOverlayStatus(
      {required this.showOverlay, required this.listNote});

  final bool showOverlay;
  final List<Note> listNote;

  @override
  List<Object?> get props => [showOverlay, listNote];
}

class DeleteNote extends NoteEvent {
  const DeleteNote({required this.noteId});

  final int noteId;

  @override
  List<Object?> get props => [noteId];
}
