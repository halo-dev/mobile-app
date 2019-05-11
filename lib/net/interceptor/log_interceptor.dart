import 'dart:math' as math;

import 'package:dio/dio.dart';

/// 参考okhttp的HttpLoggingInterceptor输出log
class PrintLogInterceptor extends Interceptor {
  int logSize = 2048;

  @override
  onRequest(RequestOptions options) {
    print("┌────── Request ─────────────────────────");
    printKV("│ " + 'uri', options.uri);
    printKV("│ " + 'method', options.method);
    printKV("│ " + 'contentType', options.contentType.toString());
    printKV("│ " + 'responseType', options.responseType.toString());
    print("┝────── Header ─────────────────────────");
    Map headers = options.headers;
    for (var key in headers.keys) {
      printKV("│ " + key, headers[key]);
    }
    print("└────────────────────────────────────");
    if (options.data != null) {
      print("┝────── Params ────────────────────────");
      printAll(options.data);
      print("└────────────────────────────────────");
    }
  }

  @override
  onError(DioError err) {
    print("┌────── DioError ────────────────────────");
    print(err);
    if (err.response != null) {
      _printResponse(err.response);
    }
    print("└────────────────────────────────────");
  }

  @override
  onResponse(Response response) {
    print("┌────── Response ────────────────────────");
    _printResponse(response);
    print("└────────────────────────────────────");
  }

  void _printResponse(Response response) {
    printKV("│ " + 'uri', response.request.uri);
    printKV("│ " + 'statusCode', response.statusCode);
    print("│ " + "Response Text:");
    printAll(response.toString());
  }

  printKV(String key, Object v) {
    print('$key: $v');
  }

  printAll(msg) {
    msg.toString().split("\n").forEach(_printAll);
  }

  _printAll(String msg) {
    int groups = (msg.length / logSize).ceil();
    for (int i = 0; i < groups; ++i) {
      print((i > 0 ? '│ <<Log follows the previous line: ' : '│ ') +
          msg.substring(
              i * logSize, math.min<int>(i * logSize + logSize, msg.length)));
    }
  }
}
