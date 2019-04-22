import 'package:flutter/material.dart';
import 'package:halo/module/article.dart';
import 'package:halo/net/api.dart';
import 'package:halo/net/api_request.dart';

class ArticleListModule extends ChangeNotifier {
  List<Content> articleList = List();

  void refresh(bool up) {
    ApiRequest(Api.getPosts(), (data) {
      if (up) {
        articleList.clear();
      }
      Article article = Article.fromJson(data);
      articleList.addAll(article.content);
      notifyListeners();
    }, (code, msg) {
      if (up) {
        articleList.clear();
      }
      notifyListeners();
    }, () {
      articleList.clear();
      articleList.add(Content());
      notifyListeners();
    });
  }
}
