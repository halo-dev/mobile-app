import 'package:flutter/material.dart';
import 'package:halo/event/dialog_event.dart';
import 'package:halo/util/Utils.dart';

class BaseNotifier extends ChangeNotifier {
  void hideLoading() {
    RxBus().post(DialogChangeEvent.showChanged(false));
  }

  void showLoading({String msg = "加载中"}) {
    RxBus().post(DialogChangeEvent(true, msg));
  }

  void showMsg(String msg) {
    ToastUtil.showToast(msg);
  }
}
