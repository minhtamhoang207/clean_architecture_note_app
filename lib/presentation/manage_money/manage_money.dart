import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:just_notes/core/injection/injection.dart';
import 'package:just_notes/core/util/app_colors.dart';
import 'package:just_notes/data/models/expense_model.dart';
import 'package:just_notes/domain/usecases/expense_usecase/add_expense_usecase.dart';
import 'package:just_notes/presentation/manage_money/bloc/manage_money_bloc.dart';
import 'package:just_notes/widgets/empty_widget.dart';

import '../add_expense/add_expense_view.dart';

class ManageMoney extends StatelessWidget {
  static String routeName = 'manage_money';
  static String routeLocation = '/manage_money';
  const ManageMoney({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ManageMoneyBloc>()..add(GetAllUserExpense()),
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            centerTitle: false,
            title: const Text('Wallet'),
            actions: [
              BlocBuilder<ManageMoneyBloc, ManageMoneyState>(
                builder: (context, state) {
                  return IconButton(
                      onPressed: () async {
                        final bool? reload = await context.pushNamed(AddExpenseView.routeName);
                        if (context.mounted && (reload ?? false)) {
                          context.read<ManageMoneyBloc>().add(GetAllUserExpense());
                        }
                      },
                      icon: const Icon(Icons.add_circle_outline_sharp)
                  );
                },
              )
            ],
          ),
          body: BlocBuilder<ManageMoneyBloc, ManageMoneyState>(
            builder: (context, state) {
              switch (state.status) {
                case ManageMoneyStatus.loading:
                  return const Center(child: CircularProgressIndicator());
                case ManageMoneyStatus.success:
                  if (state.listUserExpense.isEmpty) {
                    return const EmptyWidget();
                  } else {
                    return RefreshIndicator.adaptive(
                      onRefresh: () async {
                        context.read<ManageMoneyBloc>().add(GetAllUserExpense());
                      },
                      child: ListView(
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
                                final userExpense = state.listUserExpense[index];
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            userExpense.user?.name ?? '',
                                            style: const TextStyle(color: Colors.white),
                                          ),
                                          const Gap(6),
                                          Text(
                                            userExpense.expense?.note ?? '',
                                            style: const TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      )
                                    ),
                                    Text(
                                      '${userExpense.expense?.amount}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: (userExpense.expense?.amount ?? 0 ) < 0
                                            ? AppColors.orange
                                            : AppColors.greenSheen
                                      ),
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder: (_, __) => const Divider(
                                  height: 30, color: AppColors.greenSheen, thickness: 1.5),
                              itemCount: state.listUserExpense.length)
                        ],
                      )
                    );
                  }
                case ManageMoneyStatus.failure:
                  return const EmptyWidget();
                default:
                  return const EmptyWidget();
              }
            },
          ),
      ),
    );
  }
}
