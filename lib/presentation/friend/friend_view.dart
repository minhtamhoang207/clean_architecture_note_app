import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:just_notes/core/injection/injection.dart';
import 'package:just_notes/core/util/app_colors.dart';
import 'package:just_notes/presentation/friend/bloc/friend_bloc.dart';
import 'package:just_notes/widgets/empty_widget.dart';

class FriendView extends StatelessWidget {
  const FriendView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<FriendBloc>()..add(GetAllFriend()),
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            centerTitle: false,
            title: const Text('Friends'),
          ),
          body: BlocBuilder<FriendBloc, FriendState>(
            builder: (context, state) {
              switch (state.status) {
                case GetFriendStatus.loading:
                  return const Center(child: CircularProgressIndicator());
                case GetFriendStatus.success:
                  if (state.listFriend.isEmpty) {
                    return const EmptyWidget();
                  } else {
                    return ListView.separated(
                      itemCount: state.listFriend.length,
                      padding: const EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: AppColors.primaryColor,
                            ),
                            const Gap(12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.listFriend[index].name ?? '',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  const Gap(8),
                                  const Text(
                                    '...',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      },
                      separatorBuilder: (_, __) =>
                      const Divider(color: AppColors.ruddyBrown, height: 20),
                    );
                  }
                case GetFriendStatus.failure:
                  return const EmptyWidget();
                default:
                  return const EmptyWidget();
              }
            },
          )
      ),
    );
  }
}
