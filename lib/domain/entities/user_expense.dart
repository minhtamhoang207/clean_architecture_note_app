import 'package:just_notes/domain/entities/expense.dart';
import 'package:just_notes/domain/entities/user.dart';

class UserExpense {
  UserExpense(
      {this.expense, this.user});

  final User? user;
  final Expense? expense;
}
