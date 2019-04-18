import 'package:flutter/material.dart';
import 'package:halo/module/comment.dart';
import 'package:halo/net/api.dart';
import 'package:halo/net/api_request.dart';

class CommentListModule extends ChangeNotifier {
  List<Comment> commentList = List();

  void refresh(bool up) {
    ApiRequest(Api().getPosts(), (data) {
      if (up) {
        commentList.clear();
      }
      CommentList list = CommentList.fromJson(data);
      commentList.addAll(list.list);
      notifyListeners();
    }, (code, msg) {
      if (up) {
        commentList.clear();
      }
      notifyListeners();
    }, () {
      commentList.clear();
      commentList.add(Comment());
      notifyListeners();
    });
  }
}
