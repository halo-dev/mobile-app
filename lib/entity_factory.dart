import 'package:halo/module/admin/counts.dart';
import 'package:halo/module/article.dart';
import 'package:halo/module/attachments.dart';
import 'package:halo/module/category_list.dart';
import 'package:halo/module/comment_entity.dart';
import 'package:halo/module/options.dart';
import 'package:halo/module/post_param.dart';
import 'package:halo/module/tag_list.dart';
import 'package:halo/module/user/profile.dart';
import 'package:halo/module/user/token.dart';
import 'package:halo/util/Utils.dart';

class EntityFactory {
  /// Json generate code
  static T generateOBJ<T>(json) {
    if (T.toString() == "Article") {
      return Post.fromJson(json) as T;
    } else if (T.toString() == "Counts") {
      return Counts.fromJson(json) as T;
    } else if (T.toString() == "Profile") {
      return Profile.fromJson(json) as T;
    } else if (T.toString() == "TagList") {
      return TagList.fromJson(json) as T;
    } else if (T.toString() == "Tag") {
      return Tag.fromJson(json) as T;
    } else if (T.toString() == "CategoryList") {
      return CategoryList.fromJson(json) as T;
    } else if (T.toString() == "Category") {
      return Category.fromJson(json) as T;
    } else if (T.toString() == "PostParam") {
      return PostParam.fromJson(json) as T;
    } else if (T.toString() == "Post") {
      return Post.fromJson(json) as T;
    } else if (T.toString() == "Token") {
      return Token.fromJson(json) as T;
    } else if (T.toString() == "Options") {
      return Options.fromJson(json) as T;
    } else if (T.toString() == "Attachments") {
      return Attachments.fromJson(json) as T;
    } else if (T.toString() == "Comment") {
      return Comment.fromJson(json) as T;
    } else if (T.toString() == "AttachmentsContent") {
      return AttachmentsContent.fromJson(json) as T;
    } else {
      Log("实体类${T.toString()}没有注册到EntityFactory");
      return null;
    }
  }
}
