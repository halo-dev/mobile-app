import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:halo/module/post_param.dart';
import 'package:halo/util/Utils.dart';
import 'package:halo/widget/markdown/markdown_editor.dart';

///默认状态

const String PUBLISHED = "PUBLISHED";
const String DRAFT = "DRAFT";
const String RECYCLE = "RECYCLE";
final HashMap<String, String> status = HashMap<String, String>()
  ..[PUBLISHED] = "发布"
  ..[DRAFT] = "草稿";

class EditPostModule extends ChangeNotifier {
//  Post editPost;
  PostParam param;

  void setPostParam(PostParam newPost) {
    if (newPost == null) {
      param = PostParam.fromParams(status: PUBLISHED);
    } else
      param = newPost;
  }

  String getTitle() {
    if (param != null && isNotEmpty(param.title)) {
      return param.title;
    } else
      return "";
  }

  String getContent() {
    if (param != null && isNotEmpty(param.originalContent)) {
      return param.originalContent;
    } else
      return "";
  }

  void onPostChange(
      {topPriority,
      disallowComment,
      createFrom,
      originalContent,
      password,
      status,
      template,
      thumbnail,
      title,
      url,
      categoryIds,
      tagIds}) {
    param.status = status;
    notifyListeners();
  }

  void saveParam(MarkdownText mk) {
    if (isNotEmpty(param.originalContent) && param.originalContent == mk.text) {
      ///没有修改
    }
    param.originalContent = mk.text;
    param.title = mk.title;
  }

  String getStatus() {
    return status[param.status];
  }
}
