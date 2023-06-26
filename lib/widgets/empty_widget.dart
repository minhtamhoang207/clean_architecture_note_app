import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:just_notes/core/util/app_colors.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
