import 'dart:collection';

import 'package:halo/net/http/dio_manager.dart';

class RequestInfo {
  static final RequestInfo _singleton = new RequestInfo._internal();

  factory RequestInfo() {
    return _singleton;
  }

  RequestInfo._internal();

  String _HOST = "";
  String _REFRESH = "";

//  String _TOKEN = "";
  HashMap<String, String> _params = HashMap();

//
  HashMap<String, String> get params => _params;

  set HOST(String value) {
    _HOST = value;
    DioManager().updateHost(value);
  }

  set TOKEN(String value) {
//    _TOKEN = value;
    params["ADMIN-Authorization"] = value;
  }

//  String get TOKEN => _TOKEN;

  String get HOST => _HOST;

  String get REFRESH => _REFRESH;

  update(String token, String host, String refreshToken) {
    _HOST = host;
    _REFRESH = refreshToken;
    DioManager().updateHost(host);
    params["ADMIN-Authorization"] = token;
  }
}
