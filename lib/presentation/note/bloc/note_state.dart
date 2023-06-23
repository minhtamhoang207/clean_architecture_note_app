part of 'note_bloc.dart';

abstract class NoteState extends Equatable {
  const NoteState();
}

class NoteInitial extends NoteState {
  @override
  List<Object?> get props => [];
}

class LoadingNote extends NoteState {
  @override
  List<Object?> get props => [];

}

class LoadNoteSuccess extends NoteState {
  const LoadNoteSuccess({
    required this.listNote,
    this.showOverlay = false
  });

  final List<Note> listNote;
  final bool showOverlay;
  @override
  List<Object> get props => [listNote, showOverlay];

}

class LoadNoteFailed extends NoteState {
  const LoadNoteFailed();

  @override
  List<Object> get props => [];
}
