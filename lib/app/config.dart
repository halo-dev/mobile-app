import 'package:flutter/material.dart';

class Config {
  // ignore: non_constant_identifier_names
  static final DEBUG = true;

  /// //////////////////////////////////////HTTP 错误////////////////////////////////////// ///
  static const int TIME_OUT = 408;
  static const int RESPONSE_ERROR = 5000;
  static const int UNKNOW_ERROR = 10000;
  static const int RXDART_UNKNOW_ERROR = 11000;
  static const int NETWORK_CONNECTION_ERROR = 12000;
  static const int SERVER_ERROR = 500;

  static const String SpKey = "Site_Key";
  static const Color background = Color.fromARGB(255, 233, 239, 243);
  static const Color fontColor = Color.fromARGB(255, 61, 89, 109);
  static const Color fontLightColor = Color.fromARGB(255, 102, 142, 170);
  static const Color lightColor = Color.fromARGB(255, 13, 141, 193);
  static const Color titleColor = Color.fromARGB(255, 0, 135, 190);
}
