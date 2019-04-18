import 'package:dio/dio.dart';
import 'package:halo/app/request_info.dart';
import 'package:halo/net/interceptor/dio_interceptor.dart';
import 'package:halo/net/interceptor/dio_response_interceptor.dart';
import 'package:halo/net/interceptor/log_interceptor.dart';
import 'package:halo/util/log_util.dart';

///dio管理
class DioManager {
  static final DioManager _singleton = new DioManager._internal();

  factory DioManager() {
    return _singleton;
  }

  DioManager._internal();

  Dio _dio;

  Dio dio() {
    if (_dio != null && _dio.options.baseUrl.isNotEmpty)
      return _dio;
    else {
      // 或者通过传递一个 `options`来创建dio实例
//      LogInterceptor logInterceptor = LogInterceptor();
      BaseOptions options = new BaseOptions(
          baseUrl: RequestInfo().HOST,
          connectTimeout: 5000,
          receiveTimeout: 3000,
          responseType: ResponseType.json);
      _dio = new Dio(options);
//      _dio.options.validateStatus = (int status) {
//        return status == 0;
//      };
      //dio 2.0 支持多拦截器
      //先加载数据
      //参数拦截器
      _dio.interceptors.add(DioRequestInterceptor());
      //结果
      _dio.interceptors.add(DioResponseInterceptor());
      //日志拦截
      _dio.interceptors.add(PrintLogInterceptor());
      //代理
//      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
//        // config the http client
//        client.findProxy = (uri) {
//          //proxy all request to localhost:8888
//          return "PROXY 192.168.4.106:8888";
//        };
//        // you can also create a new HttpClient to dio
//        // return new HttpClient();
//      };
      return _dio;
    }
  }

  void update() {
    _dio.options.baseUrl = RequestInfo().HOST;
    Log(RequestInfo().HOST);
  }
}
