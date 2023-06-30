import 'dart:developer';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:just_notes/core/injection/injection.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:just_notes/data/models/expense_model.dart';
import 'package:just_notes/domain/entities/user.dart';
import 'package:just_notes/presentation/add_expense/bloc/add_expense_bloc.dart';
import '../../core/util/app_colors.dart';

class AddExpenseView extends StatefulWidget {
  static String get routeName => 'add_expense';
  static String get routeLocation => '/add_expense';
  const AddExpenseView({super.key});

  @override
  State<AddExpenseView> createState() => _AddExpenseViewState();
}

class _AddExpenseViewState extends State<AddExpenseView> {

  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AddExpenseBloc>()..add(GetAllFriend()),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: false,
          title: const Text('Add expense'),
          actions: [
            BlocConsumer<AddExpenseBloc, AddExpenseState>(
              listener: (context, state) {
                switch (state.addExpenseStatus) {
                  case AddExpenseStatus.success:
                    break;
                  case AddExpenseStatus.initial:
                    break;
                  case AddExpenseStatus.loading:
                    break;
                  case AddExpenseStatus.failure:
                    log(state.errorMessage ?? '');
                    break;
                  case AddExpenseStatus.empty:
                    context.pop(false);
                    break;
                  case AddExpenseStatus.addSuccess:
                    context.pop(true);
                    break;
                }
              },
              builder: (context, state) {
                return TextButton(
                    onPressed: () async {
                      context.read<AddExpenseBloc>().add(ConfirmAddExpense(
                        expenseModel: ExpenseModel(
                            userId: state.currentFriend?.id ?? 0,
                            amount: int.parse(
                              _amountController.text.replaceAll('.', '').trim()
                            ),
                            note: _noteController.text,
                            createAt: DateTime.now().millisecondsSinceEpoch
                        )
                      ));
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
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          children: [
            SizedBox(
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Enter amount: ',
                    style: TextStyle(
                        color: AppColors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: TextFormField(
                      controller: _amountController,
                      inputFormatters: [
                        CurrencyTextInputFormatter(
                          locale: 'vi',
                          decimalDigits: 0,
                          symbol: '',
                        )
                      ],
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                      onChanged: (value) {
                        print(_amountController.text);
                      },
                      decoration: const InputDecoration(
                        hintText: '0',
                        hintStyle: TextStyle(
                          color: AppColors.primaryColor
                        ),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.orange
                            )
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.greenSheen,
                              width: 2
                            )
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(30),
            SizedBox(
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Note',
                    style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 15
                    ),
                  ),
                  const Gap(20),
                  Expanded(
                    child: TextFormField(
                      controller: _noteController,
                      style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                      decoration: const InputDecoration(
                        hintText: 'write something about this ...',
                        hintStyle: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400
                        ),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.orange
                            )
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.greenSheen,
                                width: 2
                            )
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(30),
            BlocBuilder<AddExpenseBloc, AddExpenseState>(
              builder: (context, state) {
                if (state.addExpenseStatus == AddExpenseStatus.success) {
                  return DropdownButtonHideUnderline(
                    child: DropdownButton2<User>(
                      isExpanded: true,
                      hint: const Text(
                        'Select a friend',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.white,
                        ),
                      ),
                      items: state.listFriend
                          .map((item) => DropdownMenuItem(
                        value: item,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: item.avatar == null
                                    ? const CircleAvatar(
                                        backgroundColor: AppColors.beaver,
                                      )
                                    : CircleAvatar(
                                        backgroundColor: AppColors.beaver,
                                        backgroundImage: FileImage(
                                            item.avatar!
                                        )
                                      ),
                              ),
                              const Gap(10),
                              Expanded(
                                child: Text(
                                  item.name ?? '',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.white
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      )).toList(),
                      value: state.currentFriend,
                      onChanged: (value) {
                        context.read<AddExpenseBloc>().add(
                            SelectFriend(friend: value)
                        );
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor
                        )
                      ),
                      dropdownStyleData: const DropdownStyleData(
                          maxHeight: 200,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor
                          )
                      ),
                      menuItemStyleData: MenuItemStyleData(
                        height: 50,
                        overlayColor: MaterialStateProperty.resolveWith((states) {
                          return AppColors.greenSheen;
                        })
                      ),
                      dropdownSearchData: DropdownSearchData(
                        searchController: _searchController,
                        searchInnerWidgetHeight: 50,
                        searchInnerWidget: Container(
                          height: 50,
                          color: AppColors.primaryColor,
                          padding: const EdgeInsets.only(
                            top: 8,
                            bottom: 4,
                            right: 8,
                            left: 8,
                          ),
                          child: TextFormField(
                            expands: true,
                            maxLines: null,
                            style: const TextStyle(
                              color: AppColors.white
                            ),
                            controller: _searchController,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              hintText: 'Search for a friend...',
                              hintStyle: const TextStyle(
                                fontSize: 13,
                                color: AppColors.white
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: AppColors.oceanBlue
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: AppColors.greenSheen
                                )
                              ),
                            ),
                          ),
                        ),
                        searchMatchFn: (item, searchValue) {
                          return (item.value?.name ?? '')
                              .toLowerCase().toString().contains(searchValue);
                        },
                      ),
                      //This to clear the search value when you close the menu
                      onMenuStateChange: (isOpen) {
                        if (!isOpen) {
                          _searchController.clear();
                        }
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          ],
        ),
      )
    );
  }
}
