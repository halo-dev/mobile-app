class Options {
  String ossQiniuZone;
  String blogLocale;
  String blogUrl;
  String emailProtocol;
  String blogTitle;
  String commentContentPlaceholder;
  String emailPassword;
  String seoVerificationBaidu;
  String seoBaiduToken;
  String emailFromName;
  String seoDescription;
  String theme;
  String blogLogo;
  String blogFooterInfo;
  String ossUpyunPassword;
  String seoVerificationQihu;
  String commentCustomStyle;
  String emailUsername;
  String blogFavicon;
  String commentGavatarDefault;
  String seoVerificationGoogle;
  String ossUpyunOperator;
  String attachmentType;
  String seoVerificationBing;
  String emailHost;
  String seoKeywords;
  bool commentNewNotice;
  bool emailEnabled;
  bool commentApiEnabled;
  bool commentPassNotice;
  bool spiderDisabled;
  bool apiEnabled;
  bool commentNewNeedCheck;
  bool isInstalled;
  bool commentReplyNotice;
  int emailSslPort;
  int rssPageSize;
  int postIndexPageSize;
  int commentPageSize;
  int postSummaryLength;
  num birthday;

  Options(
      {this.ossQiniuZone,
      this.blogLocale,
      this.blogUrl,
      this.emailProtocol,
      this.blogTitle,
      this.commentContentPlaceholder,
      this.emailPassword,
      this.seoVerificationBaidu,
      this.seoBaiduToken,
      this.emailFromName,
      this.seoDescription,
      this.theme,
      this.blogLogo,
      this.blogFooterInfo,
      this.ossUpyunPassword,
      this.seoVerificationQihu,
      this.commentCustomStyle,
      this.emailUsername,
      this.blogFavicon,
      this.commentGavatarDefault,
      this.seoVerificationGoogle,
      this.ossUpyunOperator,
      this.attachmentType,
      this.seoVerificationBing,
      this.emailHost,
      this.seoKeywords,
      this.commentNewNotice,
      this.emailEnabled,
      this.commentApiEnabled,
      this.commentPassNotice,
      this.spiderDisabled,
      this.apiEnabled,
      this.commentNewNeedCheck,
      this.isInstalled,
      this.commentReplyNotice,
      this.emailSslPort,
      this.rssPageSize,
      this.postIndexPageSize,
      this.commentPageSize,
      this.postSummaryLength,
      this.birthday});

  Options.fromJson(Map<String, dynamic> json) {
    this.ossQiniuZone = json['oss_qiniu_zone'];
    this.blogLocale = json['blog_locale'];
    this.blogUrl = json['blog_url'];
    this.emailProtocol = json['email_protocol'];
    this.blogTitle = json['blog_title'];
    this.commentContentPlaceholder = json['comment_content_placeholder'];
    this.emailPassword = json['email_password'];
    this.seoVerificationBaidu = json['seo_verification_baidu'];
    this.seoBaiduToken = json['seo_baidu_token'];
    this.emailFromName = json['email_from_name'];
    this.seoDescription = json['seo_description'];
    this.theme = json['theme'];
    this.blogLogo = json['blog_logo'];
    this.blogFooterInfo = json['blog_footer_info'];
    this.ossUpyunPassword = json['oss_upyun_password'];
    this.seoVerificationQihu = json['seo_verification_qihu'];
    this.commentCustomStyle = json['comment_custom_style'];
    this.emailUsername = json['email_username'];
    this.blogFavicon = json['blog_favicon'];
    this.commentGavatarDefault = json['comment_gavatar_default'];
    this.seoVerificationGoogle = json['seo_verification_google'];
    this.ossUpyunOperator = json['oss_upyun_operator'];
    this.attachmentType = json['attachment_type'];
    this.seoVerificationBing = json['seo_verification_bing'];
    this.emailHost = json['email_host'];
    this.seoKeywords = json['seo_keywords'];
    this.commentNewNotice = json['comment_new_notice'];
    this.emailEnabled = json['email_enabled'];
    this.commentApiEnabled = json['comment_api_enabled'];
    this.commentPassNotice = json['comment_pass_notice'];
    this.spiderDisabled = json['seo_spider_disabled'];
    this.apiEnabled = json['api_enabled'];
    this.commentNewNeedCheck = json['comment_new_need_check'];
    this.isInstalled = json['is_installed'];
    this.commentReplyNotice = json['comment_reply_notice'];
    this.emailSslPort = json['email_ssl_port'];
    this.rssPageSize = json['rss_page_size'];
    this.postIndexPageSize = json['post_index_page_size'];
    this.commentPageSize = json['comment_page_size'];
    this.postSummaryLength = json['post_summary_length'];
    this.birthday = json['birthday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oss_qiniu_zone'] = this.ossQiniuZone;
    data['blog_locale'] = this.blogLocale;
    data['blog_url'] = this.blogUrl;
    data['email_protocol'] = this.emailProtocol;
    data['blog_title'] = this.blogTitle;
    data['comment_content_placeholder'] = this.commentContentPlaceholder;
    data['email_password'] = this.emailPassword;
    data['seo_verification_baidu'] = this.seoVerificationBaidu;
    data['seo_baidu_token'] = this.seoBaiduToken;
    data['email_from_name'] = this.emailFromName;
    data['seo_description'] = this.seoDescription;
    data['theme'] = this.theme;
    data['blog_logo'] = this.blogLogo;
    data['blog_footer_info'] = this.blogFooterInfo;
    data['oss_upyun_password'] = this.ossUpyunPassword;
    data['seo_verification_qihu'] = this.seoVerificationQihu;
    data['comment_custom_style'] = this.commentCustomStyle;
    data['email_username'] = this.emailUsername;
    data['blog_favicon'] = this.blogFavicon;
    data['comment_gavatar_default'] = this.commentGavatarDefault;
    data['seo_verification_google'] = this.seoVerificationGoogle;
    data['oss_upyun_operator'] = this.ossUpyunOperator;
    data['attachment_type'] = this.attachmentType;
    data['seo_verification_bing'] = this.seoVerificationBing;
    data['email_host'] = this.emailHost;
    data['seo_keywords'] = this.seoKeywords;
    data['comment_new_notice'] = this.commentNewNotice;
    data['email_enabled'] = this.emailEnabled;
    data['comment_api_enabled'] = this.commentApiEnabled;
    data['comment_pass_notice'] = this.commentPassNotice;
    data['spider_disabled'] = this.spiderDisabled;
    data['api_enabled'] = this.apiEnabled;
    data['comment_new_need_check'] = this.commentNewNeedCheck;
    data['is_installed'] = this.isInstalled;
    data['comment_reply_notice'] = this.commentReplyNotice;
    data['email_ssl_port'] = this.emailSslPort;
    data['rss_page_size'] = this.rssPageSize;
    data['post_index_page_size'] = this.postIndexPageSize;
    data['comment_page_size'] = this.commentPageSize;
    data['post_summary_length'] = this.postSummaryLength;
    data['birthday'] = this.birthday;
    return data;
  }
}
