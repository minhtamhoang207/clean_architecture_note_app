import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:just_notes/core/params/add_note_param.dart';
import 'package:just_notes/core/util/app_colors.dart';
import 'package:just_notes/domain/entities/note.dart';
import 'package:just_notes/presentation/add_note/bloc/add_note_bloc.dart';

class AddNoteView extends StatefulWidget {
  static String get routeName => 'add_note';
  static String get routeLocation => '/add_note';
  final Note? note;
  const AddNoteView({super.key, this.note});

  @override
  State<AddNoteView> createState() => _AddNoteViewState();
}

class _AddNoteViewState extends State<AddNoteView> {
  late final AddNoteBloc _addNoteBloc;

  @override
  void initState() {
    _addNoteBloc = context.read<AddNoteBloc>();
    if (widget.note != null) {
      _addNoteBloc.titleController.text = widget.note?.title ?? '';
      _addNoteBloc.contentController.text = widget.note?.content ?? '';
      _addNoteBloc
          .add(ToggleImportant(isImportant: widget.note?.important == 1));
    }
    super.initState();
  }

  @override
  void dispose() {
    _addNoteBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          BlocListener<AddNoteBloc, AddNoteState>(
            listener: (context, state) {
              switch (state.status) {
                case AddNoteStatus.success:
                  context.pop(true);
                  break;
                case AddNoteStatus.initial:
                  // TODO: Handle this case.
                  break;
                case AddNoteStatus.loading:
                  // TODO: Handle this case.
                  break;
                case AddNoteStatus.failure:
                  log(state.errorMessage ?? '');
                  break;
                case AddNoteStatus.empty:
                  context.pop(false);
                  break;
              }
            },
            child: TextButton(
                onPressed: () async {
                  _addNoteBloc.add(SaveNote(
                      isUpdate: widget.note != null,
                      addNoteParams: AddNoteParams(
                          id: widget.note?.id,
                          userId: 0,
                          title: _addNoteBloc.titleController.text,
                          content: _addNoteBloc.contentController.text,
                          important: _addNoteBloc.state.isImportant ? 1 : 0,
                          createAt: DateTime.now().millisecondsSinceEpoch)));
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => AppColors.primaryColor),
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(
                      color: AppColors.white, fontWeight: FontWeight.bold),
                )),
          )
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: TextField(
                  controller: _addNoteBloc.titleController,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                  decoration: InputDecoration(
                      hintText: 'Enter note title',
                      hintStyle: TextStyle(
                          color: AppColors.white.withOpacity(0.5),
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                      border: InputBorder.none),
                ),
              )),
              Padding(
                  padding: const EdgeInsets.only(bottom: 15, right: 10),
                  child: BlocBuilder<AddNoteBloc, AddNoteState>(
                    builder: (context, state) {
                      return IconButton(
                        icon: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (child, anim) =>
                                RotationTransition(
                                  turns: child.key == const ValueKey('icon1')
                                      ? Tween<double>(begin: 1, end: 0.75)
                                          .animate(anim)
                                      : Tween<double>(begin: 0.75, end: 1)
                                          .animate(anim),
                                  child: FadeTransition(
                                      opacity: anim, child: child),
                                ),
                            child: !state.isImportant
                                ? const Icon(Icons.star_border,
                                    key: ValueKey('icon1'),
                                    color: AppColors.orange)
                                : const Icon(
                                    Icons.star,
                                    color: AppColors.orange,
                                    key: ValueKey('icon2'),
                                  )),
                        onPressed: () {
                          _addNoteBloc.add(
                              ToggleImportant(isImportant: !state.isImportant));
                        },
                      );
                    },
                  ))
            ],
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: TextField(
              controller: _addNoteBloc.contentController,
              maxLines: 10000,
              style: const TextStyle(
                  color: Colors.white,
                  letterSpacing: 0.5,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                  fontSize: 15),
              decoration: InputDecoration(
                  hintText: 'Write something here...',
                  hintStyle: TextStyle(
                      color: AppColors.white.withOpacity(0.5),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  border: InputBorder.none),
            ),
          ))
        ],
      ),
    );
  }
}
