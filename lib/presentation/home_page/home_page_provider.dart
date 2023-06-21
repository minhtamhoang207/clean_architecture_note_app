import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:just_notes/core/injection/injection.dart';
import 'package:just_notes/core/params/add_note_param.dart';
import 'package:just_notes/domain/entities/note.dart';
import 'package:just_notes/domain/usecases/add_note_usecase.dart';
import 'package:just_notes/domain/usecases/delete_note_usecase.dart';
import 'package:just_notes/domain/usecases/get_note_usecase.dart';

final listNoteController = Provider<HomePageProvider>((ref) => getIt());

final listNoteFutureProvider = FutureProvider<List<Note>>((ref) {
  final controller = ref.watch(listNoteController);
  return controller.getNotes();
});

@lazySingleton
class HomePageProvider {
  HomePageProvider(
      this._addNotesUseCase, this._getNotesUseCase, this._deleteNoteUseCase)
      : super();

  final AddNotesUseCase _addNotesUseCase;
  final GetNotesUseCase _getNotesUseCase;
  final DeleteNoteUseCase _deleteNoteUseCase;

  Future<List<Note>> getNotes() async {
    final response = await _getNotesUseCase();
    return response.fold((l) => throw l.toString(), (r) => r);
  }

  Future<void> addNote({required AddNoteParams note}) async {
    await _addNotesUseCase(params: note);
  }

  Future<void> deleteNote({required int id}) async {
    final result = await _deleteNoteUseCase(params: id);
    result.fold((l) => throw l.toString(), (r) => r);
  }
}
