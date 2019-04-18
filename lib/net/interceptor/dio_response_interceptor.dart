import 'package:dio/dio.dart';
import 'package:halo/app/config.dart';
import 'package:halo/net/http/result_data.dart';
import 'package:halo/util/log_util.dart';

class DioResponseInterceptor extends Interceptor {
  @override
  onResponse(Response response) {
    if (null != response.data['code']) {
      //有时候 code 为string 有时候 为 int
      var code = response.data['code'];
      if (code.runtimeType.toString() == "String") code = int.parse(response.data['code']);
      response.data = ResultData.fromParams(code, response.data['data'], response.data['msg']);
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
      e.response.data = ResultData.fromParams(
          e.response != null ? e.response.statusCode : Config.RESPONSE_ERROR, null, e.message);
    } else {
      e.response.data = ResultData.fromParams(Config.UNKNOW_ERROR, null, '未知错误');
    }
    return e;
  }
}
