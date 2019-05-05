import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:halo/app/config.dart';
import 'package:halo/net/http/dio_manager.dart';
import 'package:halo/net/http/result_data.dart';
import 'package:halo/util/log_util.dart';

typedef void OnResponse(ResultData data);

class Http {
  static void request(String url,
      {Map<String, dynamic> params, String method, OnResponse res}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
//    无网络连接
    Log(connectivityResult);
    ResultData data;
    if (connectivityResult == ConnectivityResult.none) {
      data = ResultData.fromParams(Config.NETWORK_CONNECTION_ERROR, null, '无网络连接');
    }
    Response response;
    try {
      if (method == null) {
        //默认get
        method = "";
      }
      switch (method.toLowerCase()) {
        case "get":
          if (params != null && params.isNotEmpty) {
            response = await DioManager().dio().get(url, queryParameters: params);
          } else {
            response = await DioManager().dio().get(url);
          }
          break;
        case "put":
          if (params != null && params.isNotEmpty) {
            response = await DioManager().dio().put(url, data: params);
          } else {
            response = await DioManager().dio().put(url);
          }
          break;
        case "post":
          if (params != null && params.isNotEmpty) {
            response = await DioManager().dio().post(url, data: params);
          } else {
            response = await DioManager().dio().post(url);
          }
          break;
        case "delete":
          if (params != null && params.isNotEmpty) {
            response = await DioManager().dio().delete(url, queryParameters: params);
          } else {
            response = await DioManager().dio().delete(url);
          }
          break;
        default:
          if (params != null && params.isNotEmpty) {
            response = await DioManager().dio().get(url, queryParameters: params);
          } else {
            response = await DioManager().dio().get(url);
          }
      }
    } on DioError catch (e) {
      response = onDioError(e);
    }
    data = response.data;
    res(data);
  }

  static Response onDioError(DioError e) {
    if (e.response != null) {
      var status = e.response.data['status'];
      return Response(data: ResultData.fromParams(status, null, e.response.data['message']));
    } else {
      if (e.type == DioErrorType.CONNECT_TIMEOUT || e.type == DioErrorType.SEND_TIMEOUT) {
        return Response(data: ResultData.fromParams(Config.TIME_OUT, null, '连接超时,请检查服务器地址是否正确'));
      } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
        return Response(data: ResultData.fromParams(Config.TIME_OUT, null, '连接超时，请检查是否连接网络'));
      } else {
        return Response(data: ResultData.fromParams(Config.UNKNOW_ERROR, null, '未知错误'));
      }
    }
  }
}
