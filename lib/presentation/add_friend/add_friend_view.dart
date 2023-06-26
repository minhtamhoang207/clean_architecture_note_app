import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:just_notes/core/injection/injection.dart';
import 'package:just_notes/core/util/app_colors.dart';
import 'package:just_notes/data/models/user_model.dart';
import 'package:just_notes/presentation/add_friend/bloc/add_friend_bloc.dart';

class AddFriendView extends StatefulWidget {
  static String get routeName => 'add_friend';
  static String get routeLocation => '/add_friend';
  const AddFriendView({super.key});

  @override
  State<AddFriendView> createState() => _AddFriendViewState();
}

class _AddFriendViewState extends State<AddFriendView> {

  final _bloc = getIt<AddFriendBloc>();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        actions: [
          BlocListener<AddFriendBloc, AddFriendState>(
            listener: (context, state) {
              switch (state.addFriendStatus) {
                case AddFriendStatus.success:
                  context.pop(true);
                  break;
                case AddFriendStatus.initial:
                // TODO: Handle this case.
                  break;
                case AddFriendStatus.loading:
                // TODO: Handle this case.
                  break;
                case AddFriendStatus.failure:
                  log(state.errorMessage ?? '');
                  break;
                case AddFriendStatus.empty:
                  context.pop(false);
                  break;
              }
            },
            child: TextButton(
                onPressed: () async {
                  _bloc.add(ConfirmAddFriend(userModel: UserModel(
                    id: DateTime.now().millisecondsSinceEpoch,
                    name: _nameController.text.trim(),
                    createAt: DateTime.now().millisecondsSinceEpoch,
                  )));
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
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(
            height: 100,
            width: 100,
            child: CircleAvatar(
              backgroundColor: AppColors.primaryColor,
            ),
          ),
          const Gap(35),
          TextFormField(
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.white),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.white),
              ),
              hintText: 'Enter name ...',
              hintStyle: TextStyle(
                color: AppColors.white
              )
          ))
        ],
      ),
    );
  }
}
