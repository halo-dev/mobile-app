import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:halo/module/article.dart';
import 'package:halo/module/category_list.dart';
import 'package:halo/module/post_param.dart';
import 'package:halo/net/api.dart';
import 'package:halo/net/api_request.dart';
import 'package:halo/util/Utils.dart';

class PostListModule extends ChangeNotifier {
  List<Content> articleList = List();
  int status;
  int indexPage = 0;

  void refresh(bool up,
      {Category cate, String key = "", String postStatus = ""}) {
    if (up) {
      indexPage = 0;
    }
    Map params = HashMap<String, dynamic>();
    params["categoryId"] = cate == null ? 0 : cate.id;
    params["keyword"] = key;
    params["page"] = indexPage;
    params["status"] = postStatus;
    params["size"] = 15;

    ApiRequest<Post>(Api.posts, GET, (data) {
      status = 200;
      if (up) {
        articleList.clear();
      }
      articleList.addAll(data.content);
      ++indexPage;
      notifyListeners();
    }, (code, msg) {
      status = code;
      if (up) {
        articleList.clear();
      }
      notifyListeners();
    }, () {
//      articleList.clear();
//      articleList.add(Content());
//      notifyListeners();
    });
  }

  void createPost(PostParam param) {
    ApiWithQuery(Api.posts, POST, param.toJson(), (data) {
      notifyListeners();
    }, (code, msg) {
      ToastUtil.showToast(msg);
    }, () {
      notifyListeners();
    });
  }
}
