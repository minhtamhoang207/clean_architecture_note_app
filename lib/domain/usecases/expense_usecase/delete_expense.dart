import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:just_notes/domain/repositories/i_note_repository.dart';
import '../../../core/usecase/usecase.dart';

@lazySingleton
class DeleteExpenseUseCase extends UseCase<void, int> {
  DeleteExpenseUseCase(this.repository);

  final INoteRepository repository;

  @override
  Future<Either<Exception, void>> call({required int params}) {
    return repository.deleteExpense(expenseId: params);
  }
}
