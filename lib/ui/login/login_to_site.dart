import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:halo/app/request_info.dart';
import 'package:halo/module/user/profile.dart';
import 'package:halo/net/api.dart';
import 'package:halo/net/api_request.dart';
import 'package:halo/ui/login/site_info.dart';
import 'package:halo/util/jump_page.dart';
import 'package:halo/util/toast.dart';

class LoginToSite {
  void login(String url, String user, String pwd, BuildContext context) {
    //更新请求地址
    RequestInfo().HOST = url;
    //参数
    Map params = HashMap<String, String>();
    params["username"] = user;
    params["password"] = pwd;

    ApiRequest(Api.login(params), (data) {
      pushToNewPage(context, SiteInfo(Profile.fromJson(data), pwd));
    }, (code, msg) {
      ToastUtil.show(msg, context);
    }, () {});
  }
}
