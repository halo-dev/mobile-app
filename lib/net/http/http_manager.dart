import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:halo/app/config.dart';
import 'package:halo/app/request_info.dart';
import 'package:halo/event/login_change_event.dart';
import 'package:halo/module/user/token.dart';
import 'package:halo/net/api.dart';
import 'package:halo/net/http/dio_manager.dart';
import 'package:halo/net/http/result_data.dart';
import 'package:halo/util/Utils.dart';

typedef void OnResponse(ResultData data);

class Http {
  static void request(String url,
      {Map<String, dynamic> params, String method, OnResponse res}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
//    无网络连接
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
      if (e.response != null && e.response.data['status'] == 401) {
        /// token过期
        /// 锁定状态
        DioManager().dio().lock();
        DioManager().dio().post(Api.refresh(RequestInfo().REFRESH)).then((data) {
          Token token = Token.fromJson(data);
          RequestInfo().update(token.access_token, RequestInfo().HOST, token.refresh_token);
          Utils.updateSite(token);
        }).catchError((err) {
          Utils.updateSite(Token.fromParams());
          RxBus().post(LoginChangeEvent());
          response = Response(data: ResultData.fromParams(400, null, "Token过期，请重新登陆"));
        });
        DioManager().dio().unlock();
        RequestOptions options = e.response.request;
        options.headers
          ..clear()
          ..addAll(RequestInfo().params);
        response = await DioManager().dio().request(options.path, options: options);
      } else
        response = onDioError(e);
    }
    data = response.data;
    res(data);
  }

  static Response onDioError(DioError e) {
    if (e.response != null) {
      var status = e.response.data['status'];
      if (status == 400 &&
          e.response.data['message'] == "The refresh token may have been expired already") {
        Utils.updateSite(Token.fromParams());
        return Response(data: ResultData.fromParams(status, null, "Token过期，请重新登陆"));
      } else {
        return Response(data: ResultData.fromParams(status, null, e.response.data['message']));
      }
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
