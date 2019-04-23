import 'package:halo/module/admin/counts.dart';
import 'package:halo/module/article.dart';
import 'package:halo/module/category_list.dart';
import 'package:halo/module/tag_list.dart';
import 'package:halo/module/tag_list.dart' as tagList;
import 'package:halo/module/user/profile.dart';
import 'package:halo/util/Utils.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (T.toString() == "Article") {
      return Article.fromJson(json) as T;
    } else if (T.toString() == "Counts") {
      return Counts.fromJson(json) as T;
    } else if (T.toString() == "Profile") {
      return Profile.fromJson(json) as T;
    } else if (T.toString() == "TagList") {
      return TagList.fromJson(json) as T;
    } else if (T.toString() == "Tag") {
      return tagList.Tag.fromJson(json) as T;
    } else if (T.toString() == "CategoryList") {
      return CategoryList.fromJson(json) as T;
    } else if (T.toString() == "Category") {
      return Category.fromJson(json) as T;
    } else {
      Log("实体类${T.toString()}没有注册", key: "EntityFactory");
      return null;
    }
  }
}
