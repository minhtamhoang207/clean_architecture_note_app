import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:just_notes/core/params/login_param.dart';
import 'package:just_notes/domain/repositories/i_auth_repository.dart';
import '../../core/usecase/usecase.dart';

@lazySingleton
class AuthUseCase extends UseCase<void, LoginParams> {
  AuthUseCase(this.repository);

  final IAuthRepository repository;

  @override
  Future<Either<Exception, void>> call({required LoginParams params}) {
    return repository.login(loginParams: params);
  }
}
