import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:halo/module/category_list.dart';
import 'package:halo/net/api.dart';
import 'package:halo/net/api_request.dart';
import 'package:halo/util/Utils.dart';
import 'package:halo/util/toast.dart';

class CategoryListModule extends ChangeNotifier {
  CategoryList cateList;
  int status;

  void updateList() {
    ApiRequest<CategoryList>(Api.categoryTreeView, GET, (data) {
      cateList = data;
      if (cateList != null && cateList.list.isEmpty) {
        cateList.list = List();
      }
      notifyListeners();
    }, (code, msg) {
      status = code;
      ToastUtil.showToast(msg);
      notifyListeners();
    }, () {});
  }

  void delete(Category category) {
    ApiRequest<CategoryList>(Api.deleteCategory(category.id), DELETE, (data) {
      updateList();
    }, (code, msg) {
      ToastUtil.showToast(msg);
      notifyListeners();
    }, () {});
  }

  void update(Category category, BuildContext context) {
    Map params = HashMap<String, dynamic>();
    params["slugName"] = category.slugName;
    params["description"] = category.description;
    params["name"] = category.name;
    params["parentId"] = category.parentId;
//    params["id"] = category.id;
    ApiWithQuery<Category>(Api.deleteCategory(category.id), PUT, params, (data) {
      ToastUtil.showToast("修改成功");
      Navigator.pop(context);
    }, (code, msg) {
      ToastUtil.showToast(msg);
      notifyListeners();
    }, () {});
  }

  void create(Category category, BuildContext context) {
    Map params = HashMap<String, dynamic>();
    params["slugName"] = category.slugName;
    params["description"] = category.description;
    params["name"] = category.name;
    params["parentId"] = category.parentId;
    ApiWithQuery<Category>(Api.category, POST, params, (data) {
      ///创建成功
      ToastUtil.showToast("分类创建成功");
      Navigator.pop(context);
    }, (code, msg) {
      ToastUtil.showToast(msg);
    }, () {});
  }

  Category top = Category.fromParams(id: 0, parentId: 0, description: "", name: "顶级");

  Category findParentById(List<Category> list, int id) {
    Category defaultData;
    list.forEach((data) {
      if (id == data.id) {
        defaultData = data;
      } else {
        if (data.children != null) {
          defaultData = findParentById(data.children, id);
        }
      }
    });
    return defaultData;
  }

  Category current;

  Category currentCategory(Category item) {
    if (item.parentId == 0) {
      current = top;
    } else
      current = findParentById(cateList.list, item.parentId);
  }

  Category currentChange(Category item) {
    current = item;
    notifyListeners();
  }
}
