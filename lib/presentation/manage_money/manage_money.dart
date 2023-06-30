import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:just_notes/core/injection/injection.dart';
import 'package:just_notes/core/util/app_colors.dart';
import 'package:just_notes/core/util/date_time.dart';
import 'package:just_notes/core/util/string_util.dart';
import 'package:just_notes/presentation/manage_money/bloc/manage_money_bloc.dart';
import 'package:just_notes/widgets/empty_widget.dart';

import '../add_expense/add_expense_view.dart';

class ManageMoney extends StatelessWidget {
  static String routeName = 'manage_money';
  static String routeLocation = '/manage_money';
  final int? userId;
  const ManageMoney({super.key, this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ManageMoneyBloc>()..add(GetAllUserExpense(
        userId: userId
      )),
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
                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<ManageMoneyBloc>().add(GetAllUserExpense(
                          userId: userId
                        ));
                      },
                      child: ListView(
                        children: [
                          const Gap(15),
                          GestureDetector(
                            onTap: () {
                              context.read<ManageMoneyBloc>().add(
                                  ToggleShowIncome(showIncome: !state.showIncome)
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: AppColors.greenSheen.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.attach_money, size: 18, color: Colors.white),
                                  const Text(
                                    'Income:',
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                    ),
                                  ),
                                  const Gap(15),
                                  Expanded(
                                    child: Text(
                                      state.showIncome
                                          ? StringUtils.formatVNDCurrency(
                                              state.totalIncome
                                            )
                                          : '*******',
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Gap(15),
                          GestureDetector(
                            onTap: () {
                              context.read<ManageMoneyBloc>().add(
                                ToggleShowExpense(showExpense: !state.showExpense)
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: AppColors.beaver.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.money_off, size: 18, color: Colors.white),
                                  const Text(
                                    'Expense: ',
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                    ),
                                  ),
                                  const Gap(15),
                                  Expanded(
                                    child: Text(
                                      state.showExpense
                                        ? StringUtils.formatVNDCurrency(
                                              state.totalExpense
                                          )
                                        : '*******',
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Gap(20),
                          ListView.separated(
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(bottom: 150),
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final userExpense = state.listUserExpense[index];
                                return Slidable(
                                  enabled: true,
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    // dismissible: DismissiblePane(
                                    //     onDismissed: () {
                                    //       context.read<FriendBloc>().add(
                                    //           DeleteFriend(
                                    //               friendId: state.listFriend[index].id
                                    //           )
                                    //       );
                                    //     }
                                    // ),
                                    children: [
                                      SlidableAction(
                                        onPressed: (_) {
                                          context.read<ManageMoneyBloc>().add(
                                              DeleteExpense(
                                                expenseId: userExpense.expense?.id ?? 0,
                                                userId: userId
                                              )
                                          );
                                        },
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete_forever,
                                        label: 'Delete',
                                      ),
                                    ],
                                  ),
                                  key: ValueKey(index),
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        color: (userExpense.expense?.amount ?? 0 ) < 0
                                            ? AppColors.orange.withOpacity(0.1)
                                            : AppColors.greenSheen.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: IntrinsicHeight(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          userExpense.user?.avatar == null
                                              ? const CircleAvatar(
                                            backgroundColor: AppColors.beaver,
                                          )
                                              : CircleAvatar(
                                              backgroundColor: AppColors.beaver,
                                              backgroundImage: FileImage(
                                                  userExpense.user!.avatar!
                                              )
                                          ),
                                          const Gap(15),
                                          Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    userExpense.user?.name ?? '',
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w600
                                                    ),
                                                  ),
                                                  const Gap(6),
                                                  Text(
                                                    userExpense.expense?.note ?? '',
                                                    style: TextStyle(
                                                        color: Colors.white.withOpacity(0.8),
                                                        fontSize: 13
                                                    ),
                                                  ),
                                                  const Gap(10),
                                                  Text(
                                                    DateTimeUtils.formatDateFromInt(
                                                        userExpense.expense?.createAt ?? 0,
                                                        Pattern.ddMMyyyyHHmmss
                                                    ),
                                                    style: const TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 10,
                                                        color: AppColors.white
                                                    ),
                                                  ),
                                                ],
                                              )
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Text(
                                              StringUtils.formatVNDCurrency(
                                                  userExpense.expense?.amount ?? 0
                                              ),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  color: (userExpense.expense?.amount ?? 0 ) < 0
                                                      ? AppColors.orange
                                                      : AppColors.greenSheen
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  )
                                );
                              },
                              separatorBuilder: (_, __) => const Divider(
                                  height: 30, color: AppColors.beaver, thickness: .3),
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
