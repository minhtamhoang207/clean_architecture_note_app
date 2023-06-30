import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
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

  late final AddFriendBloc _bloc;
  final _nameController = TextEditingController();

  @override
  void initState() {
    _bloc = context.read<AddFriendBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        actions: [
          BlocConsumer<AddFriendBloc, AddFriendState>(
            listener: (context, state) {
              switch (state.addFriendStatus) {
                case AddFriendStatus.success:
                  context.pop(true);
                  break;
                case AddFriendStatus.initial:
                // TODO: Handle this case.
                  break;
                case AddFriendStatus.loading:
                  break;
                case AddFriendStatus.failure:
                  log(state.errorMessage ?? '');
                  break;
                case AddFriendStatus.empty:
                  context.pop(false);
                  break;
              }
            },
            builder: (context, state) {
              return TextButton(
                  onPressed: () async {

                    List<int> fileBytes = await state.avatar?.readAsBytes() ?? [];
                    String? base64Image = fileBytes.isEmpty
                        ? null
                        : base64Encode(fileBytes);

                    _bloc.add(ConfirmAddFriend(userModel: UserModel(
                      name: _nameController.text.trim(),
                      avatar: base64Image,
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
                  ));
            },
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          GestureDetector(
            onTap: () async {
              final ImagePicker picker = ImagePicker();
              final XFile? image = await picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                _bloc.add(PickAvatar(avatar: File(image.path)));
              }
            },
            child: BlocBuilder<AddFriendBloc, AddFriendState>(
              builder: (context, state) {
                return Container(
                  height: 100,
                  width: 100,
                  decoration: state.avatar == null
                    ? const BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle
                      )
                   : BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: FileImage(state.avatar!)
                        )
                    )
                );
              },
            )
          ),
          const Gap(35),
          TextFormField(
            controller: _nameController,
            style: const TextStyle(
              color: AppColors.white
            ),
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
