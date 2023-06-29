import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:just_notes/core/usecase/usecase.dart';
import 'package:just_notes/data/models/expense_model.dart';
import 'package:just_notes/domain/repositories/i_note_repository.dart';

@lazySingleton
class AddExpenseUseCase extends UseCase<void, ExpenseModel> {
  AddExpenseUseCase(this.repository);

  final INoteRepository repository;

  @override
  Future<Either<Exception, void>> call({required ExpenseModel params}) {
    return repository.addExpense(param: params);
  }
}
