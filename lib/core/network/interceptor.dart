import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

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
