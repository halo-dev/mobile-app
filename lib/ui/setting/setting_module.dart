import 'package:halo/app/base/base_notifier.dart';
import 'package:halo/module/options.dart';
import 'package:halo/net/api.dart';
import 'package:halo/net/api_request.dart';

class SettingModule extends BaseNotifier {
  Options options;
  int status;

  void getSiteTitle() {
    showLoading();
    ApiRequest<Options>(Api.options, GET, (data) {
      status = 200;
      options = data;
      notifyListeners();
    }, (code, msg) {
      status = code;
      showMsg(msg);
      notifyListeners();
    }, () {
      hideLoading();
    });
  }

  void saveSetting() {
    showLoading();
    ApiWithQuery(Api.savingOptions, POST, options.toJson(), (data) {
      getSiteTitle();
      showMsg("保存成功");
      hideLoading();
      notifyListeners();
    }, (code, msg) {
      showMsg(msg);
      notifyListeners();
    }, () {
      hideLoading();
    });
  }
}
