import 'package:flutter/material.dart';
import 'package:just_notes/core/injection/injection.dart';
import 'package:just_notes/core/params/login_param.dart';
import 'package:just_notes/domain/usecases/add_note_usecase.dart';
import 'package:just_notes/domain/usecases/auth_usecase.dart';
import 'package:just_notes/domain/usecases/get_note_usecase.dart';

import '../core/params/add_note_param.dart';
import '../domain/entities/note.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GetNotesUseCase _getNotes = getIt<GetNotesUseCase>();
  final AddNotesUseCase _addNotes = getIt<AddNotesUseCase>();
  final AuthUseCase _authUseCase = getIt();
  List<Note> listNotes = [];

  @override
  void initState() {
    _getNotes.call().then((value){
      listNotes = value.fold((l) => [], (r) => r);
    });
    _authUseCase.call(params: LoginParams(password: '123456', username: 'tamhm1')).then((value){
      value.fold((l) => print(l), (r) => print("SUCCESS__________"));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: listNotes.length,
        itemBuilder: (context, index){
          return ListTile(
            leading: Text('${listNotes[index].id} ${listNotes[index].title}'),
            title: Text(listNotes[index].content),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _addNotes.call(params: AddNoteParams(
              'hello',
              'every one'
          )).then((value){
            _getNotes.call().then((value){
              setState(() {
                listNotes = value.fold((l) => [], (r) => r);
              });
            });
          });
        },
      ),
    );
  }
}
