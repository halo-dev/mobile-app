import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:halo/app/request_info.dart';
import 'package:halo/module/options.dart';
import 'package:halo/module/user/profile.dart';
import 'package:halo/module/user/token.dart';
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

    ApiWithQuery<Token>(Api.login, POST, params, (data) {
      //登陆成功更新Token
      RequestInfo().TOKEN = data.access_token;
      getSiteTitle(context, data);
    }, (code, msg) {
      ToastUtil.show(msg, context);
    }, () {});
  }

  void userProfile(BuildContext context, Token token, String title) {
    ApiRequest<Profile>(Api.profiles, GET, (data) {
      pushToNewPage(context, SiteInfo(data, token, title));
    }, (code, msg) {
      ToastUtil.show(msg, context);
    }, () {});
  }

  void getSiteTitle(BuildContext context, Token token) {
    ApiRequest<Options>(Api.options, GET, (data) {
      userProfile(context, token, data.blog_title);
    }, (code, msg) {
      ToastUtil.show(msg, context);
    }, () {});
  }
}
