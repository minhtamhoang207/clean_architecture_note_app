import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:just_notes/core/util/app_colors.dart';

class ManageMoney extends StatelessWidget {
  static String routeName = 'manage_money';
  static String routeLocation = '/manage_money';
  const ManageMoney({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: false,
          title: const Text('Wallet'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add_circle_outline_sharp,
                  color: Colors.white),
            )
          ],
        ),
        body: ListView(
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              color: AppColors.primaryColor,
            ),
            const Gap(20),
            ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.all(10),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Content content content content content',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Text(
                        '+2.000.000',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  );
                },
                separatorBuilder: (_, __) => const Divider(
                    height: 30, color: AppColors.greenSheen, thickness: 1.5),
                itemCount: 10)
          ],
        ));
  }
}
