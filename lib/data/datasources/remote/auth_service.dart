import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:just_notes/core/params/login_param.dart';
import 'package:just_notes/core/util/constants.dart';
import 'package:retrofit/http.dart';

part 'auth_service.g.dart';

@lazySingleton
@RestApi(baseUrl: Constants.baseUrl)
abstract class AuthService {
  @factoryMethod
  factory AuthService(Dio dio) = _AuthService;

  @POST('/auth/register')
  Future<void> register(@Body() LoginParams userAuth);

  @POST('/auth/login')
  Future<void> login(@Body() LoginParams userAuth);
}
