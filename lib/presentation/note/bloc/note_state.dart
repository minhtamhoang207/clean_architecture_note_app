part of 'note_bloc.dart';

abstract class NoteState extends Equatable {
  const NoteState();
}

class NoteInitial extends NoteState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoadingNote extends NoteState {
  @override
  List<Object?> get props => throw UnimplementedError();

}

class LoadNoteSuccess extends NoteState {
  const LoadNoteSuccess({required this.listNote});

  final List<Note> listNote;
  @override
  List<Object> get props => [listNote];

}

class LoadNoteFailed extends NoteState {
  const LoadNoteFailed();

  @override
  List<Object> get props => [];
}
