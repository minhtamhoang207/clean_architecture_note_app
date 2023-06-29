class Expense {
  Expense(
      {this.id,
      required this.userId,
      required this.amount,
      this.note,
      required this.createAt});

  final int? id;
  final int userId;
  final int amount;
  final String? note;
  final int createAt;
}
