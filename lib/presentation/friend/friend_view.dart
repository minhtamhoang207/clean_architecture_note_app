import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:just_notes/core/util/app_colors.dart';

class FriendView extends StatelessWidget {
  const FriendView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: false,
          title: const Text('Friends'),
        ),
        body: ListView.separated(
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return const Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                  ),
                  Gap(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hoang Minh Tam',
                          style: TextStyle(color: Colors.white),
                        ),
                        Gap(8),
                        Text(
                          '0375266302',
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
            itemCount: 3));
  }
}
