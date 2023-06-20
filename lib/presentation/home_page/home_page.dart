import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_notes/presentation/add_note/add_note.dart';
import 'package:just_notes/presentation/home_page/home_page_provider.dart';

import '../../core/util/app_colors.dart';
import '../../domain/entities/note.dart';

class HomePage extends StatefulHookConsumerWidget {
  static String get routeName => 'home_page';
  static String get routeLocation => '/home_page';
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final listNote = ref.watch(listNoteFutureProvider);
    final controller = useTextEditingController();
    final note = useState('');

    useEffect(() {
        controller.addListener(() {
          note.value = controller.text;
        });
        return () {};
      },
      [controller],
    );
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        title: const Text(
          'Notes',
          style: TextStyle(
            color: AppColors.white,
            fontStyle: FontStyle.italic
          ),
        ),
        actions: [
          IconButton(
              onPressed: (){},
              icon: const Icon(Icons.search_rounded)
          )
        ],
      ),
      body: listNote.when(
          data: (listNote) => Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 0),
            child: RefreshIndicator(
              onRefresh: () => ref.refresh(listNoteFutureProvider.future),
              child: MasonryGridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    itemCount: listNote.length,
                    itemBuilder: (context, index) {
                      return listItem(
                          listNote[listNote.length - 1 - index]
                      );
                    },
                  ),
            ),
          ),
          error: (error, stackTrace) => Center(
              child: Text(error.toString(), style: const TextStyle(
                color: AppColors.white
              ),)
          ),
          loading: () => const Center(child: CircularProgressIndicator(
            color: AppColors.greenSheen,
          ))
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final reload = await context.pushNamed(AddNote.routeName) as bool?;
          if (reload ?? false) {
            ref.invalidate(listNoteFutureProvider);
          }
        },
        backgroundColor: AppColors.greenSheen,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  _showPopupMenu(Offset offset, int id) async {
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top, left+1, top+1),
      items: [
        PopupMenuItem<String>(
            onTap: () async {
              await ref.read(listNoteController).deleteNote(id: id);
              ref.invalidate(listNoteFutureProvider);
            },
            value: 'delete',
            child: const Text('Delete'),
        ),
        // const PopupMenuItem<String>(
        //     value: 'edit',
        //     child: Text('Edit')),
      ],
      elevation: 8.0,
    );
  }

  Widget listItem(Note note) {
    return GestureDetector(
      onTapDown: (TapDownDetails details){
        _showPopupMenu(details.globalPosition, note.id);
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
                        color: note.important == 1?
                        AppColors.beaver:Colors.transparent
                    )
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.title,
                      style: const TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                    ),
                    const Gap(8),
                    Text(
                      note.content,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 6,
                      style: TextStyle(
                          color: AppColors.white.withOpacity(0.6),
                          fontWeight: FontWeight.w500,
                          fontSize: 12
                      ),
                    ),
                    const Gap(18),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${DateTime.fromMillisecondsSinceEpoch(note.createAt).day}/${DateTime.fromMillisecondsSinceEpoch(note.createAt).month.toString()}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 6,
                            style: TextStyle(
                                color: AppColors.white.withOpacity(0.6),
                                fontWeight: FontWeight.w500,
                                fontSize: 10
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'Todo',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 6,
                          style: TextStyle(
                              color: AppColors.white.withOpacity(0.6),
                              fontWeight: FontWeight.w500,
                              fontSize: 10
                          ),
                        ),
                      ],
                    )
                  ],
                )
            ),
            // if(note.id == 3) Container(
            //     padding: const EdgeInsets.all(20),
            //     decoration: BoxDecoration(
            //         color: AppColors.greenSheen.withOpacity(0.4),
            //         borderRadius: BorderRadius.circular(18),
            //     ),
            // ),
          ],
        ),
      )
    );
  }
}
