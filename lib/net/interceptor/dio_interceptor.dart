import 'dart:io';

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
    if (options.method == "POST" && options.data is FormData) {
      options.headers[HttpHeaders.contentTypeHeader] =
          'multipart/form-data; boundary=${options.data.boundary.substring(2)}';
    }
    return options;
  }
}
