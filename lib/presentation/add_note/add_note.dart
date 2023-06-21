import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_notes/core/params/add_note_param.dart';
import 'package:just_notes/core/util/app_colors.dart';
import '../home_page/home_page_provider.dart';

class AddNote extends HookConsumerWidget {
  static String get routeName => 'add_note';
  static String get routeLocation => '/add_note';
  const AddNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = useState(0);

    final titleController = useTextEditingController();
    final contentController = useTextEditingController();
    final title = useState('');
    final content = useState('');

    useEffect(
      () {
        titleController.addListener(() {
          title.value = titleController.text;
        });
        return () {};
      },
      [titleController],
    );

    useEffect(
      () {
        contentController.addListener(() {
          content.value = contentController.text;
        });
        return () {};
      },
      [contentController],
    );

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
              onPressed: () async {
                await ref
                    .read(listNoteController)
                    .addNote(
                        note: AddNoteParams(
                            userId: 0,
                            title: title.value,
                            content: content.value,
                            important: state.value,
                            createAt: DateTime.now().millisecondsSinceEpoch))
                    .then((value) {
                  context.pop(true);
                });
              },
              style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith(
                    (states) => AppColors.primaryColor),
              ),
              child: const Text(
                'Done',
                style: TextStyle(
                    color: AppColors.white, fontWeight: FontWeight.bold),
              ))
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
                  controller: titleController,
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
                child: IconButton(
                  icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, anim) => RotationTransition(
                            turns: child.key == const ValueKey('icon1')
                                ? Tween<double>(begin: 1, end: 0.75)
                                    .animate(anim)
                                : Tween<double>(begin: 0.75, end: 1)
                                    .animate(anim),
                            child: FadeTransition(opacity: anim, child: child),
                          ),
                      child: state.value == 0
                          ? const Icon(Icons.star_border,
                              key: ValueKey('icon1'), color: AppColors.orange)
                          : const Icon(
                              Icons.star,
                              color: AppColors.orange,
                              key: ValueKey('icon2'),
                            )),
                  onPressed: () {
                    state.value = state.value == 0 ? 1 : 0;
                  },
                ),
              )
            ],
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: TextField(
              controller: contentController,
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
