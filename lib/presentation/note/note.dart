import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:just_notes/core/injection/injection.dart';
import 'package:just_notes/core/util/app_colors.dart';
import 'package:just_notes/core/util/date_time.dart';
import 'package:just_notes/domain/entities/note.dart';
import 'package:just_notes/presentation/add_note/add_note.dart';
import 'package:just_notes/presentation/note/bloc/note_bloc.dart';
import 'package:gap/gap.dart';

class NoteView extends StatelessWidget {
  static String routeName = 'note';
  static String routeLocation = '/note';
  const NoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NoteBloc>()..add(GetAllNoteEvent()),
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            centerTitle: false,
            title: const Text('Note'),
            actions: [
              BlocBuilder<NoteBloc, NoteState>(
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case LoadNoteSuccess:
                      state as LoadNoteSuccess;
                      return IconButton(
                          onPressed: () async {
                            if (state.showOverlay) {
                              context.read<NoteBloc>().add(ChangeOverlayStatus(
                                  showOverlay: false,
                                  listNote: state.listNote));
                            } else {
                              final bool? reload = await context
                                  .pushNamed(AddNoteView.routeName);
                              if (context.mounted && (reload ?? false)) {
                                context.read<NoteBloc>().add(GetAllNoteEvent());
                              }
                            }
                          },
                          icon: state.showOverlay
                              ? const Icon(CupertinoIcons.arrow_turn_up_left)
                              : const Icon(Icons.add_circle_outline_sharp));
                    default:
                      return const SizedBox();
                  }
                },
              )
            ],
          ),
          body: BlocBuilder<NoteBloc, NoteState>(
            builder: (context, state) {
              switch (state.runtimeType) {
                case LoadingNote:
                  return const Center(child: CircularProgressIndicator());
                case LoadNoteSuccess:
                  state as LoadNoteSuccess;
                  if (state.listNote.isEmpty) {
                    return empty();
                  } else {
                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<NoteBloc>().add(GetAllNoteEvent());
                      },
                      child: MasonryGridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        padding: const EdgeInsets.only(top: 20, bottom: 150),
                        itemCount: state.listNote.length,
                        itemBuilder: (context, index) {
                          return listItem(state.listNote[index]);
                        },
                      ).animate().fadeIn().slide(begin: const Offset(0, -0.3)),
                    );
                  }
                default:
                  return Center(
                      child: const Icon(Icons.error, color: Colors.white)
                          .animate()
                          .fadeIn(duration: 30.ms));
              }
            },
          )),
    );
  }

  Widget listItem(Note note) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        state as LoadNoteSuccess;
        return GestureDetector(
            onTap: () async {
              final bool? reload =
                  await context.pushNamed(AddNoteView.routeName, extra: note);
              if (context.mounted && (reload ?? false)) {
                context.read<NoteBloc>().add(GetAllNoteEvent());
              }
            },
            onLongPress: () {
              context.read<NoteBloc>().add(ChangeOverlayStatus(
                  showOverlay: true, listNote: state.listNote));
            },
            child: IntrinsicHeight(
              child: Stack(
                children: [
                  Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                              color: note.important == 1
                                  ? AppColors.beaver
                                  : Colors.transparent)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  note.title ?? '',
                                  style: const TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              Visibility(
                                visible: note.important == 1,
                                child: const Icon(Icons.star,
                                    color: AppColors.orange),
                              )
                            ],
                          ),
                          const Gap(8),
                          Text(
                            note.content ?? '',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(
                                color: AppColors.white.withOpacity(0.6),
                                fontWeight: FontWeight.w500,
                                fontSize: 12),
                          ),
                          const Gap(18),
                          Text(
                            DateTimeUtils.formatDateFromInt(
                                note.createAt ?? 0, Pattern.hhmmssddMMyyyy),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 6,
                            style: TextStyle(
                                color: AppColors.white.withOpacity(0.6),
                                fontWeight: FontWeight.w500,
                                fontSize: 10),
                          ),
                        ],
                      )),
                  Visibility(
                      visible: state.showOverlay,
                      child: Container(
                        padding: const EdgeInsets.only(top: 10, right: 10),
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(18)),
                        child: Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                context
                                    .read<NoteBloc>()
                                    .add(DeleteNote(noteId: note.id ?? 0));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                    CupertinoIcons.delete_left_fill,
                                    color: Colors.red,
                                    size: 18),
                              ),
                            )),
                      ).animate().fadeIn(duration: 30.ms)),
                ],
              ),
            ));
      },
    );
  }

  Widget empty() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.note_outlined, size: 30, color: AppColors.white),
          Gap(10),
          Text(
            'Nothing to show ...',
            style: TextStyle(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
