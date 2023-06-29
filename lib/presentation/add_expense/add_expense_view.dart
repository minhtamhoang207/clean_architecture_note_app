import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:just_notes/core/injection/injection.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
            BlocListener<AddExpenseBloc, AddExpenseState>(
              listener: (context, state) {
                switch (state.addExpenseStatus) {
                  case AddExpenseStatus.success:
                    // context.pop(true);
                    break;
                  case AddExpenseStatus.initial:
                  // TODO: Handle this case.
                    break;
                  case AddExpenseStatus.loading:
                    break;
                  case AddExpenseStatus.failure:
                    log(state.errorMessage ?? '');
                    break;
                  case AddExpenseStatus.empty:
                    context.pop(false);
                    break;
                }
              },
              child: TextButton(
                  onPressed: () async {
                    // context.read<AddExpenseBloc>().add(ExpenseModel(
                    //     userId: userId,
                    //     amount: amount,
                    //     createAt: createAt
                    // ))
                    // _bloc.add(ConfirmAddFriend(userModel: UserModel(
                    //   name: _nameController.text.trim(),
                    //   id: DateTime.now().millisecondsSinceEpoch,
                    //   createAt: DateTime.now().millisecondsSinceEpoch,
                    // )));
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
          children: [
            BlocBuilder<AddExpenseBloc, AddExpenseState>(
              builder: (context, state) {
                if (state.addExpenseStatus == AddExpenseStatus.success) {
                  return DropdownButtonHideUnderline(
                    child: DropdownButton2<User>(
                      isExpanded: true,
                      hint: Text(
                        'Select Item',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: state.listFriend
                          .map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(
                          item.name ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      )).toList(),
                      value: state.listFriend.first,
                      onChanged: (value) {
                        print(value!.name);
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 40,
                        width: 200,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor
                        )
                      ),
                      dropdownStyleData: const DropdownStyleData(
                        maxHeight: 200,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                      dropdownSearchData: DropdownSearchData(
                        searchController: _searchController,
                        searchInnerWidgetHeight: 50,
                        searchInnerWidget: Container(
                          height: 50,
                          padding: const EdgeInsets.only(
                            top: 8,
                            bottom: 4,
                            right: 8,
                            left: 8,
                          ),
                          child: TextFormField(
                            expands: true,
                            maxLines: null,
                            controller: _searchController,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              hintText: 'Search for an item...',
                              hintStyle: const TextStyle(fontSize: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        searchMatchFn: (item, searchValue) {
                          return item.value.toString().contains(searchValue);
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
