import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toast/toast.dart' as FluttrToast;

class ToastUtil {
  static final ToastUtil _singleton = ToastUtil._internal();

  factory ToastUtil() {
    return _singleton;
  }

  ToastUtil._internal();

  static void show(String msg, BuildContext context) {
    FluttrToast.Toast.show(msg, context,
        duration: FluttrToast.Toast.LENGTH_SHORT, gravity: FluttrToast.Toast.CENTER);
  }

  static void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.black45,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
