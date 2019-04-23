import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:halo/module/category_list.dart';
import 'package:halo/module/tag_list.dart';
import 'package:halo/net/api.dart';
import 'package:halo/net/api_request.dart';
import 'package:halo/util/Utils.dart';
import 'package:halo/util/toast.dart';

class CategoryListModule extends ChangeNotifier {
  CategoryList cateList;
  int status;

  void updateList(BuildContext context) {
    ApiRequest<CategoryList>(Api.categoryTreeView, GET, (data) {
      cateList = data;
      notifyListeners();
    }, (code, msg) {
      status = code;
      ToastUtil.showToast(msg);
      notifyListeners();
    }, () {});
  }

  void delete(Category tag) {
    ApiRequest<CategoryList>(Api.deleteTags(tag.id), DELETE, (data) {
      cateList.list.remove(tag);
      notifyListeners();
    }, (code, msg) {
      ToastUtil.showToast(msg);
      notifyListeners();
    }, () {});
  }

  void update(Tag tag) {
    Map params = HashMap<String, dynamic>();
    params["tagId"] = tag.id;
    ApiWithQuery<TagList>(Api.category, DELETE, params, (data) {
      cateList.list.remove(tag);
      notifyListeners();
    }, (code, msg) {
      ToastUtil.showToast(msg);
      notifyListeners();
    }, () {});
  }

  void create(String name, String slug, String description, String parentId) {
    ///{
    //  "description": "string",
    //  "name": "父分类",
    //  "parentId": 1,
    //  "slugName": "string"
    //}
    Map params = HashMap<String, dynamic>();
    params["description"] = description;
    params["slugName"] = slug;
    params["parentId"] = slug;
    ApiWithQuery<Category>(Api.category, POST, params, (data) {
      cateList.list.add(data);
      notifyListeners();
    }, (code, msg) {
      ToastUtil.showToast(msg);
      notifyListeners();
    }, () {});
  }
}
