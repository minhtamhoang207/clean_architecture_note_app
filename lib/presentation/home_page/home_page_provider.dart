import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:just_notes/core/injection/injection.dart';
import 'package:just_notes/core/params/add_note_param.dart';
import 'package:just_notes/domain/entities/note.dart';
import 'package:just_notes/domain/usecases/add_note_usecase.dart';
import 'package:just_notes/domain/usecases/get_note_usecase.dart';

final homePageProvider = ChangeNotifierProvider.autoDispose<HomePageProvider>(
        (ref) => getIt());

@injectable
class HomePageProvider extends ChangeNotifier {
  HomePageProvider(this._addNotesUseCase, this._getNotesUseCase):super();

  final AddNotesUseCase _addNotesUseCase;
  final GetNotesUseCase _getNotesUseCase;
  List<Note> listNote = [];

  getNotes() async {
    final response = await _getNotesUseCase.call();
    listNote = response.fold((l) => [], (r) => r);
    notifyListeners();
  }

  addNote({required String content}) async {
    if(content.isNotEmpty){
      await _addNotesUseCase.call(params: AddNoteParams(
          '', content
      ));
      await getNotes();
    }
  }

}