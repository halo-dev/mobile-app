import 'package:dio/dio.dart';
import 'package:halo/app/config.dart';
import 'package:halo/net/http/result_data.dart';
import 'package:halo/util/log_util.dart';

class DioResponseInterceptor extends Interceptor {
  @override
  onResponse(Response response) {
    if (null != response.data['status']) {
      //有时候 code 为string 有时候 为 int
      var status = response.data['status'];
      response.data =
          ResultData.fromParams(status, response.data['data'], response.data['message']);
    } else {
      response.data = ResultData.fromParams(Config.SERVER_ERROR, null, '服务器内部错误');
    }
    return response;
  }

  @override
  onError(DioError e) {
    Log(e, key: "DioError");
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      e.response.data = ResultData.fromParams(Config.TIME_OUT, null, '连接超时');
    } else if (e.response != null) {
      var status = e.response.data['status'];
      e.response.data = ResultData.fromParams(status, null, e.response.data['message']);
    } else {
      e.response.data = ResultData.fromParams(Config.UNKNOW_ERROR, null, '未知错误');
    }
    return e;
  }
}
