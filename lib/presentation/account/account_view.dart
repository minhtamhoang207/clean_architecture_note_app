import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:just_notes/core/util/app_colors.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding:
            const EdgeInsets.only(top: 20, bottom: 150, left: 20, right: 20),
        children: [
          const SizedBox(
            height: 100,
            width: 100,
            child: CircleAvatar(
              backgroundColor: AppColors.primaryColor,
            ),
          ),
          const Gap(20),
          const Text(
            'Hoàng Minh Tâm',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
          const Gap(20),
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(18)),
          ),
          const Gap(20),
          Container(
            height: 120,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(18)),
          ),
        ],
      ),
    );
  }
}
