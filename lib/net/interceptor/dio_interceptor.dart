import 'package:dio/dio.dart';
import 'package:halo/app/request_info.dart';

class DioRequestInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options) async {
    var opt = tokenInterceptor(options);
    return opt;
  }

  /// 时间戳
  RequestOptions tokenInterceptor(RequestOptions options) {
    options.headers
      ..clear()
      ..addAll(RequestInfo().params);
    return options;
  }
}
