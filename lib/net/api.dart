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

  ///刷新token
  static String refresh(refreshToken) => "/api/admin/refresh/$refreshToken";

  //user
  static final String profiles = "/api/admin/users/profiles";
  static final String password = "/api/admin/users/profiles/password";

  ///options
  static final String options = "/api/admin/options/map_view";
  static final String savingOptions = "/api/admin/options/map_view/saving";

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

  //删除文件
  static String deleteAttach(id) => "/api/admin/attachments/$id";

  //媒体
  static final String attachments = "/api/admin/attachments";

  /// 评论
  static final String comments = "/api/admin/posts/comments";

  ///links
  static final String links = "/api/admin/links";

  //menus
  static final String menus = "/api/admin/menus";

  //themes
  static final String themes = "/api/admin/themes";
  //激活主题
  static String activation(themeId) => "/api/admin/themes/$themeId/activation";
  static String deleteTheme(themeId) => "/api/admin/themes/$themeId";
}
