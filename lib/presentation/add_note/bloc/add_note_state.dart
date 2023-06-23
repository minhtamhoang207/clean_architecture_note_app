part of 'add_note_bloc.dart';

enum AddNoteStatus { initial, loading, success, failure, empty }

class AddNoteState extends Equatable {
  const AddNoteState._({
    this.status = AddNoteStatus.initial,
    this.isImportant = false,
    this.errorMessage
  });

  final AddNoteStatus status;
  final bool isImportant;
  final String? errorMessage;

  const AddNoteState.initial() : this._();

  const AddNoteState.loading() : this._(status: AddNoteStatus.loading);

  const AddNoteState.success() : this._(status: AddNoteStatus.success);

  const AddNoteState.empty() : this._(status: AddNoteStatus.empty);

  const AddNoteState.failure({
    String? errorMessage
  }) : this._(status: AddNoteStatus.failure, errorMessage: errorMessage);

  @override
  List<Object?> get props => [status, isImportant, errorMessage];
}