import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:halo/app/base/base_notifier.dart';
import 'package:halo/app/module/site_module.dart';
import 'package:halo/app/provide.dart';
import 'package:halo/module/user/profile.dart';
import 'package:halo/net/api.dart';
import 'package:halo/net/api_request.dart';

class SetUserPreferencesModule extends BaseNotifier {
  Profile profile;
  int status;

  void getUserInfo() {
    ApiRequest<Profile>(Api.profiles, GET, (data) {
      status = 200;
      profile = data;
      notifyListeners();
    }, (code, msg) {
      status = code;
      showMsg(msg);
      notifyListeners();
    }, () {});
  }

  void updatePasswd(String old, String newPwd, BuildContext context) {
    showLoading(msg: "正在更新资料...");
    Map params = HashMap<String, dynamic>();
    params["oldPassword"] = old;
    params["newPassword"] = newPwd;
    ApiWithQuery(Api.password, PUT, params, (data) {
      hideLoading();
      Navigator.of(context).pop();
    }, (code, msg) {
      showMsg(msg);
    }, () {
      hideLoading();
    });
  }

  void update(Profile profile, BuildContext context, {bool back = true}) {
    showLoading(msg: "正在更新资料...");
    ApiWithQuery<Profile>(Api.profiles, PUT, profile.toJson(), (data) {
      status = 200;
      profile = data;
      notifyListeners();
      hideLoading();
      _updateSite(profile, context);
      if (back) {
        Navigator.of(context).pop();
      }
    }, (code, msg) {
      status = code;
      showMsg(msg);
    }, () {
      hideLoading();
    });
  }

  _updateSite(Profile profile, BuildContext context) {
    Provide.value<SiteModule>(context)
        .updateUserInfo(profile.avatar, profile.nickname, profile.username);
  }
}
