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

  /// 登陆
  static final String login = "/api/admin/login";

  //user
  static final String profiles = "/api/admin/users/profiles";

  ///options
  static final String options = "/api/admin/options/map_view";

  static final String posts = "/api/admin/posts";
  static String postDetail(postID) => "/api/admin/posts/$postID";

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
