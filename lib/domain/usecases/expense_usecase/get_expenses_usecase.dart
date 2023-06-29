import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:just_notes/core/usecase/usecase.dart';
import 'package:just_notes/domain/entities/user_expense.dart';
import 'package:just_notes/domain/repositories/i_note_repository.dart';

@lazySingleton
class GetExpenseUseCase extends UseCase<List<UserExpense>, void> {
  GetExpenseUseCase(this.repository);

  final INoteRepository repository;

  @override
  Future<Either<Exception, List<UserExpense>>> call({void params}) {
    return repository.getAllExpense();
  }
}