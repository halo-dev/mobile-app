import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:halo/app/base/base_widget.dart';
import 'package:halo/module/article.dart';
import 'package:halo/module/attachments.dart';
import 'package:halo/net/api.dart';
import 'package:halo/net/api_request.dart';

class AttachmentsModule extends ChangeNotifier {
  int indexPage = 0;
  int indexSize = 20;
  int status;
  Attachments attachments;

  void getAttachment(bool up,{String key,String type,String strong}) {
    if (up) {
      indexPage = 0;
    }
    Map params = HashMap<String, dynamic>();
    params["page"] = indexPage;
    params["size"] = indexSize;
//page=$page&size=$size
    ApiWithQuery<Attachments>(Api.attachments, GET, params, (data) {
      status = 200;
      if (up) {
        attachments?.content?.clear();
      }
      attachments = data;
      ++indexPage;
      notifyListeners();
    }, (code, msg) {
      status = code;
      if (up) {
        attachments?.content?.clear();
      }
      notifyListeners();
    }, () {
//       attachments.content.clear();
//      articleList.add(Content());
//      notifyListeners();
    });
  }
}
