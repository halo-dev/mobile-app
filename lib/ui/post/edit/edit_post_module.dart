import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:halo/module/category_list.dart';
import 'package:halo/module/post_param.dart';
import 'package:halo/module/tag_list.dart';
import 'package:halo/net/api.dart';
import 'package:halo/net/api_request.dart';
import 'package:halo/util/Utils.dart';
import 'package:halo/widget/markdown/markdown_editor.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

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
  PostParam oldDate;

  List<Tag> selectTag = List();
  List<Category> selectCategory = List();

  void setPostParam(int postDetailsId) {
    if (param == null) {
      if (postDetailsId == null || postDetailsId == 0) {
        param = PostParam.fromParams(status: PUBLISHED);
      } else {
        //进入编辑模式
        _getPostDetails(postDetailsId);
      }
    }
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
    if (param != null) {
      param.originalContent = mk.text;
      param.title = mk.title;
    }
  }

  String getStatus() {
    return status[param.status];
  }

  String allowComment() {
    return (param.disallowComment == null || !param.disallowComment) ? "允许" : "不允许";
  }

  ///添加选择的tag
  void addTagSelect(Tag tag) {
    if (!hasTag(selectTag, tag)) {
      selectTag.add(tag);
    }
    notifyListeners();
  }

  ///删除选中的tag
  void deleteTagSelect(Tag tag) {
    if (hasTag(selectTag, tag)) {
      selectTag.removeWhere((data) => data.id == tag.id);
    }
    notifyListeners();
  }

  ///
  ///筛选出 未选中的TAG
  List<Tag> getUnSelectTag(List<Tag> all) {
    List<Tag> list = new List();
    all.forEach((tag) {
      if (!hasTag(selectTag, tag)) {
        list.add(tag);
      }
    });
    return list;
  }

  bool hasTag(List<Tag> list, Tag tag) {
    bool has = false;
    list.forEach((it) {
      if (it.id == tag.id && it.name == tag.name) {
        has = true;
      }
    });
    return has;
  }

  bool hasCategory(Category tag) {
    bool has = false;
    selectCategory.forEach((it) {
      if (it.id == tag.id && it.name == tag.name) {
        has = true;
      }
    });
    return has;
  }

  void addOrRemoveCategory(Category cate) {
    if (hasCategory(cate)) {
      selectCategory.removeWhere((data) => data.id == cate.id);
    } else {
      selectCategory.add(cate);
    }
    notifyListeners();
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

  ///发送文章
  void send(BuildContext context) {
    ///数据收集
    param.categoryIds = List();
    selectCategory.forEach((cate) => param.categoryIds.add(cate.id));
    param.tagIds = List();
    selectTag.forEach((tag) => param.tagIds.add(tag.id));
    if (oldDate == null) {
      ApiWithQuery(oldDate == null ? Api.posts : Api.postDetail(oldDate.id), POST, param.toJson(),
          (data) {
        ToastUtil.showToast("文章已${param.status == PUBLISHED ? "发布" : "存为草稿"}");
        Navigator.pop(context);
      }, (code, msg) {
        ToastUtil.showToast(msg);
      }, () {
        notifyListeners();
      });
    }
  }

  List<Asset> selectThumbList;

  void loadAssets(int max) async {
    try {
      selectThumbList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: true,
        materialOptions: MaterialOptions(
          actionBarTitle: "选择照片",
          allViewTitle: "选择照片",
          actionBarColor: "#0087be",
          actionBarTitleColor: "#FFFFFF",
          lightStatusBar: false,
          statusBarColor: '#006b98',
          startInAllView: true,
          selectCircleStrokeColor: "#FFFFFF",
        ),
        cupertinoOptions: CupertinoOptions(
          selectionFillColor: "#ff11ab",
          selectionTextColor: "#FFFFFF",
          selectionCharacter: "✓",
        ),
      );
    } on PlatformException catch (e) {
      ToastUtil.showToast(e.toString());
    }
    if (selectThumbList != null && selectThumbList.isNotEmpty) {
      notifyListeners();
    }
  }

  removeThumbList() {
    if (selectThumbList != null) selectThumbList.clear();
    notifyListeners();
  }

  ///如果编辑文章时做了改变事退出，提示
  bool onBackNotSave() {
    if (oldDate == null) {
      return true;
    } else {
      return isNotChanged();
    }
  }

  /// 新建文章时候退出，
  bool hasChanged() {
    return param != null &&
        (isNotEmpty(param.title) || isNotEmpty(param.originalContent)) &&
        oldDate == null;
  }

  //文章是否有改变
  bool isNotChanged() {
    return param.toString() == oldDate.toString();
  }

  void cleanData() {
    selectTag.clear();
    selectCategory.clear();
    if (selectThumbList != null) {
      selectThumbList.clear();
    }
    param = null;
    oldDate = null;
  }

  void _getPostDetails(int id) {
    ApiRequest<PostParam>(Api.postDetail(id), GET, (data) {
      oldDate = data;
      param = data;
      notifyListeners();
    }, (code, msg) {
      ToastUtil.showToast(msg);
    }, () {});
  }
}
