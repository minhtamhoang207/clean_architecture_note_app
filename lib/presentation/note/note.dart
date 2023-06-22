import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:just_notes/core/util/app_colors.dart';
import 'package:just_notes/presentation/add_note/add_note.dart';
import 'package:just_notes/presentation/note/bloc/note_bloc.dart';

class NoteView extends StatelessWidget {
  static String routeName = 'note';
  static String routeLocation ='/note';
  const NoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NoteBloc()..add(GetAllNoteEvent()),
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            centerTitle: false,
            title: const Text(
                'Note'
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    context.pushNamed(AddNote.routeName);
                  },
                  icon: const Icon(Icons.add_circle_outline_sharp)
              )
            ],
          ),
          body: BlocBuilder<NoteBloc, NoteState>(
            builder: (context, state) {
              switch (state.runtimeType) {
                case LoadingNote:
                  return const Center(child: CircularProgressIndicator());
                case LoadNoteSuccess:
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<NoteBloc>().add(GetAllNoteEvent());
                    },
                    child: MasonryGridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 200,
                          width: 200,
                          color: AppColors.primaryColor,
                        );
                      },
                    )
                        .animate()
                        .fadeIn()
                        .slide(begin: const Offset(0, -0.3)),
                  );
                default:
                  return Center(child: const Icon(Icons.error, color: Colors.white).animate().shake());
              }
            },
          )
      ),
    );
  }
}
