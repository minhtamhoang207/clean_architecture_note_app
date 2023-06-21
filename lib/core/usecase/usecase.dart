import 'package:dartz/dartz.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Exception, Type>> call({required Params params});
}
