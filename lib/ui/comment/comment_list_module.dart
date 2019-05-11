import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:halo/module/comment_entity.dart';
import 'package:halo/net/api.dart';
import 'package:halo/net/api_request.dart';

class CommentListModule extends ChangeNotifier {
  int indexPage = 0;
  int indexSize = 20;
  int status;
  Comment comment;

  void getComment(bool up,{String key,String statusType}) {
    if (up) {
      indexPage = 0;
    }
    Map params = HashMap<String, dynamic>();
    params["page"] = indexPage;
    params["size"] = indexSize;
//page=$page&size=$size
    ApiWithQuery<Comment>(Api.comments, GET, params, (data) {
      status = 200;
      if (up) {
        comment?.content?.clear();
      }
      comment = data;
      ++indexPage;
      notifyListeners();
    }, (code, msg) {
      status = code;
      if (up) {
        comment?.content?.clear();
      }
      notifyListeners();
    }, () {
//       attachments.content.clear();
//      articleList.add(Content());
//      notifyListeners();
    });
  }
}
