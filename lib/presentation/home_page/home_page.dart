import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_notes/core/util/focus.dart';
import 'package:just_notes/domain/entities/note.dart';
import 'package:just_notes/presentation/home_page/home_page_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  static String get routeName => 'home_page';
  static String get routeLocation => '/home_page';
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {

  TextEditingController note = TextEditingController();

  @override
  void initState() {
    ref.read(homePageProvider).getNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Note> listNote = ref.watch(homePageProvider).listNote;
    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: AppBar(
        title: TextField(
          controller: note,
          decoration: const InputDecoration(
            hintText: 'Enter something here',
            hintStyle: TextStyle(
              color: Colors.white
            )
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: listNote.length,
        itemBuilder: (context, index){
          return Card(
            child: ListTile(
              title: Text(listNote[listNote.length - 1 - index].content),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNote,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> addNote() async {
    await ref.read(homePageProvider).addNote(
        content: note.text
    );
    note.clear();
    AppFocus.unFocus();
  }
}
