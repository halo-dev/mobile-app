import 'dart:collection';

import 'package:halo/net/http/dio_manager.dart';

class RequestInfo {
  static final RequestInfo _singleton = new RequestInfo._internal();

  factory RequestInfo() {
    return _singleton;
  }

  RequestInfo._internal();

  String _HOST = "";
  HashMap<String, String> _params = HashMap();

  HashMap<String, String> get params => _params;

  set HOST(String value) {
    _HOST = value;
    DioManager().update(value);
  }

  String get HOST => _HOST;
}
