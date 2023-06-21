import 'package:dartz/dartz.dart';
import 'package:just_notes/core/params/login_param.dart';

abstract class IAuthRepository {
  Future<Either<Exception, void>> login({required LoginParams loginParams});
}
