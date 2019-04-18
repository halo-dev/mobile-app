import 'package:flutter/widgets.dart';
import 'package:toast/toast.dart';

class ToastUtil {
  static final ToastUtil _singleton = ToastUtil._internal();

  factory ToastUtil() {
    return _singleton;
  }

  ToastUtil._internal();

  static void show(String msg, BuildContext context) {
    Toast.show(msg, context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }
}
