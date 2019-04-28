import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:halo/module/post_param.dart';
import 'package:halo/module/tag_list.dart';
import 'package:halo/util/Utils.dart';
import 'package:halo/widget/markdown/markdown_editor.dart';

///默认状态

const String PUBLISHED = "PUBLISHED";
const String DRAFT = "DRAFT";
const String RECYCLE = "RECYCLE";
final HashMap<String, String> status = HashMap<String, String>()
  ..[DRAFT] = "草稿"
  ..[PUBLISHED] = "发布";
final HashMap<bool, String> comments = HashMap<bool, String>()
  ..[false] = "允许"
  ..[true] = "不允许";

class EditPostModule extends ChangeNotifier {
//  Post editPost;
  PostParam param;
  List<Tag> selectTag = List();
  List<Tag> selectCategory = List();

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

  void onStatusChange(String status) {
    param.status = status;
    notifyListeners();
  }

  void onPasswordChange(String password) {
    param.password = password;
    notifyListeners();
  }

  void onUrlChange(String url) {
    param.url = url;
    notifyListeners();
  }

  void onCommentChange(bool comment) {
    param.disallowComment = comment;
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

  String allowComment() {
    return (param.disallowComment == null || !param.disallowComment) ? "允许" : "不允许";
  }

  ///添加选择的tag
  void addTagSelect(Tag tag) {
    if (!selectTag.contains(tag)) {
      selectTag.add(tag);
    }
    notifyListeners();
  }

  void deleteTagSelect(Tag tag) {
    if (selectTag.contains(tag)) {
      selectTag.remove(tag);
    }
    notifyListeners();
  }

  ///
  ///
  List<Tag> getUnSelectTag(List<Tag> all) {
    List<Tag> list = new List();
    all.forEach((tag) {
      if (!hasTag(tag)) {
        list.add(tag);
      }
    });
    return list;
  }

  bool hasTag(Tag tag) {
    bool has = false;
    selectTag.forEach((it) {
      if (it.id == tag.id && it.name == tag.name) {
        has = true;
      }
    });
    return has;
  }

  String getSelectTag() {
    if (selectTag.isEmpty) {
      return "未设置";
    } else {
      String select = "";
      selectTag.forEach((tag) {
        select += tag.name + "，";
      });
      return select.substring(0, select.length - 1);
    }
  }

  String getSelectCategory() {
    if (selectCategory.isEmpty) {
      return "未设置";
    } else {
      String select = "";
      selectCategory.forEach((tag) {
        select += tag.name + "，";
      });
      return select.substring(0, select.length - 1);
    }
  }
}
