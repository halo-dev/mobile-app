import 'package:dio/dio.dart';
import 'package:halo/app/config.dart';
import 'package:halo/net/http/result_data.dart';

class DioResponseInterceptor extends Interceptor {
  @override
  onResponse(Response response) {
    if (null != response.data['status']) {
      var status = response.data['status'];
      response.data = ResultData.fromParams(
          status, response.data['data'], response.data['message']);
    } else {
      response.data =
          ResultData.fromParams(Config.SERVER_ERROR, null, '服务器内部错误');
    }
    return response;
  }
}
