import 'package:halo/app/base/base_notifier.dart';
import 'package:halo/module/themes.dart';
import 'package:halo/net/api.dart';
import 'package:halo/net/api_request.dart';

class SetThemeModule extends BaseNotifier {
  ThemesList themesList;
  int status;

  void getThemeList() {
    showLoading();
    ApiRequest<ThemesList>(Api.themes, GET, (data) {
      status = 200;
      themesList = data;
      notifyListeners();
    }, (code, msg) {
      status = code;
      showMsg(msg);
      notifyListeners();
    }, () {
      hideLoading();
    });
  }

  void activation(String themeId) {
    showLoading();
    ApiRequest(Api.activation(themeId), POST, (data) {
      getThemeList();
    }, (code, msg) {
      showMsg(msg);
      notifyListeners();
    }, () {
      hideLoading();
    });
  }

  void deleteTheme(String themeId) {
    showLoading();
    ApiRequest(Api.deleteTheme(themeId), DELETE, (data) {
      getThemeList();
    }, (code, msg) {
      showMsg(msg);
      notifyListeners();
    }, () {
      hideLoading();
    });
  }
}
