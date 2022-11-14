import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:just_notes/core/injection/injection.dart';
import 'package:just_notes/core/params/login_param.dart';
import 'package:just_notes/data/datasources/remote/auth_service.dart';
import 'package:just_notes/domain/repositories/i_auth_repository.dart';
import '../../core/network/network_info.dart';

@LazySingleton(as: IAuthRepository)
class AuthRepository implements IAuthRepository {
  AuthRepository(this._networkInfo, this._authService);

  final AuthService _authService;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<Exception, void>> login({required LoginParams loginParams}) async {
    if (await _networkInfo.isConnected) {
      try {
        await _authService.login(loginParams);
        return const Right(null);
      } catch (e) {
        return Left(Exception(e));
      }
    } else {
      return const Left(SocketException(''));
    }
  }
}
