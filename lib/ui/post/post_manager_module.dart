import 'package:flutter/material.dart';
import 'package:halo/module/article.dart';
import 'package:halo/module/post_param.dart';
import 'package:halo/net/api.dart';
import 'package:halo/net/api_request.dart';
import 'package:halo/util/Utils.dart';

class PostListModule extends ChangeNotifier {
  List<Content> articleList = List();
  int status;

  void refresh(bool up) {
    ApiRequest<Post>(Api.posts, GET, (data) {
      status = 200;
      if (up) {
        articleList.clear();
      }
      articleList.addAll(data.content);
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
