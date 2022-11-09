import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:just_notes/core/util/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@lazySingleton
class RestClient {
  Dio init() {
    final dio = Dio()..options = BaseOptions(baseUrl: Constants.baseUrl);
    dio.interceptors.addAll([
      AppInterceptors(),
      PrettyDioLogger(
          requestHeader: false,
          responseHeader: false,
          requestBody: true,
          responseBody: true,
          error: true,
          compact: true,
          maxWidth: 90)
    ]);
    return dio;
  }
}

@LazySingleton(as: Interceptor)
class AppInterceptors implements Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // SharedPreferences prefs = Get.find<SharedPreferences>();
    // final token = prefs.getString(kBearerToken);
    // options.headers.putIfAbsent('Authorization', () => 'Bearer $token');
    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }
}