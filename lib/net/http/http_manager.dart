import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:halo/app/config.dart';
import 'package:halo/net/http/dio_manager.dart';
import 'package:halo/net/http/result_data.dart';
import 'package:halo/util/log_util.dart';

class Http {
  ///get请求
  static Future<ResultData> get(String url, {Map<String, dynamic> query, String baseUrl}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
//    //无网络连接
    if (connectivityResult == ConnectivityResult.none) {
      return ResultData.fromParams(Config.NETWORK_CONNECTION_ERROR, null, '无网络连接');
    }

    Response response;
    if (baseUrl.isNotEmpty) url = baseUrl + url;
    try {
      if (query != null && query.isNotEmpty) {
        response = await DioManager().dio().get(url, queryParameters: query);
      } else {
        response = await DioManager().dio().get(url);
      }
    } on DioError catch (e) {
      return e.response.data;
    }
    return response.data;
  }

  ///post请求
  static Future<ResultData> post(String url, {Map<String, dynamic> params}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
//    无网络连接
    Log(connectivityResult);
    if (connectivityResult == ConnectivityResult.none) {
      return ResultData.fromParams(Config.NETWORK_CONNECTION_ERROR, null, '无网络连接');
    }

    Response response;
    try {
      if (params != null && params.isNotEmpty) {
        response = await DioManager().dio().post(url, data: params);
      } else {
        response = await DioManager().dio().post(url);
      }
    } on DioError catch (e) {
      return e.response.data;
    }
    return response.data;
  }
}
