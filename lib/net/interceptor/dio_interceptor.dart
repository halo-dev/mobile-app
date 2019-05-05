import 'package:dio/dio.dart';
import 'package:halo/app/request_info.dart';

class DioRequestInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options) async {
    var opt = tokenInterceptor(options);
    return opt;
  }

//  /// token
  RequestOptions tokenInterceptor(RequestOptions options) {
//    HashMap<String, String> params = HashMap();
//    params["ADMIN-Authorization"] = RequestInfo().TOKEN;
    options.headers
      ..clear()
      ..addAll(RequestInfo().params);
    return options;
  }
}
