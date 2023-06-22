part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();
}

class GetAllNoteEvent extends NoteEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}