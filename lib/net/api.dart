import 'package:halo/net/http/http_manager.dart';
import 'package:halo/net/http/result_data.dart';
import 'package:rxdart/rxdart.dart';

const String BaseUrl = "http://www.apkdv.com";

class Api {
  ///邮箱账号

  ///
  /// 登录,获取Token
  ///
  ///
  /// 获取用户信息
  /// @param system_type
  /// @return User
//修改密码
  static Observable<ResultData> updatePassword(Map<String, dynamic> query) =>
      Observable.fromFuture(Http.get("/api/admin/posts", query: query));

  /// 登陆

  static final String login = "/api/admin/login";
  static final String posts = "/api/admin/posts";

  /// tag ///
  /// tag list
  static final String listTags = "/api/admin/tags";

  static String deleteTags(tagID) => "/api/admin/tags/$tagID";

  ///
  static final String category = "/api/admin/categories";

  ///删除分类
  static String deleteCategory(id) => "/api/admin/categories/$id";
  static final String categoryTreeView = "/api/admin/categories/tree_view";

  ///上传文件
  static final String upload = "/api/admin/attachments/upload";
}
