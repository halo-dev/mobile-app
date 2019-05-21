import 'dart:convert' show json;

class Options {
  int birthday;
  int comment_page_size;
  int email_ssl_port;
  int post_index_page_size;
  int post_summary_length;
  int rss_page_size;
  bool api_enabled;
  bool comment_api_enabled;
  bool comment_new_need_check;
  bool comment_new_notice;
  bool comment_pass_notice;
  bool comment_reply_notice;
  bool email_enabled;
  bool is_installed;
  bool spider_disabled;
  String attachment_type;
  String blog_footer_info;
  String blog_locale;
  String blog_title;
  String blog_url;
  String comment_content_placeholder;
  String comment_custom_style;
  String comment_gavatar_default;
  String email_from_name;
  String email_host;
  String email_password;
  String email_protocol;
  String email_username;
  String oss_qiniu_zone;
  String oss_upyun_operator;
  String oss_upyun_password;
  String seo_keywords;
  String theme;

  Options.fromParams(
      {this.birthday,
      this.comment_page_size,
      this.email_ssl_port,
      this.post_index_page_size,
      this.post_summary_length,
      this.rss_page_size,
      this.api_enabled,
      this.comment_api_enabled,
      this.comment_new_need_check,
      this.comment_new_notice,
      this.comment_pass_notice,
      this.comment_reply_notice,
      this.email_enabled,
      this.is_installed,
      this.spider_disabled,
      this.attachment_type,
      this.blog_footer_info,
      this.blog_locale,
      this.blog_title,
      this.blog_url,
      this.comment_content_placeholder,
      this.comment_custom_style,
      this.comment_gavatar_default,
      this.email_from_name,
      this.email_host,
      this.email_password,
      this.email_protocol,
      this.email_username,
      this.oss_qiniu_zone,
      this.oss_upyun_operator,
      this.oss_upyun_password,
      this.seo_keywords,
      this.theme});

  factory Options(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new Options.fromJson(json.decode(jsonStr))
          : new Options.fromJson(jsonStr);

  Options.fromJson(jsonRes) {
    birthday = jsonRes['birthday'];
    comment_page_size = jsonRes['comment_page_size'];
    email_ssl_port = jsonRes['email_ssl_port'];
    post_index_page_size = jsonRes['post_index_page_size'];
    post_summary_length = jsonRes['post_summary_length'];
    rss_page_size = jsonRes['rss_page_size'];
    api_enabled = jsonRes['api_enabled'];
    comment_api_enabled = jsonRes['comment_api_enabled'];
    comment_new_need_check = jsonRes['comment_new_need_check'];
    comment_new_notice = jsonRes['comment_new_notice'];
    comment_pass_notice = jsonRes['comment_pass_notice'];
    comment_reply_notice = jsonRes['comment_reply_notice'];
    email_enabled = jsonRes['email_enabled'];
    is_installed = jsonRes['is_installed'];
    spider_disabled = jsonRes['spider_disabled'];
    attachment_type = jsonRes['attachment_type'];
    blog_footer_info = jsonRes['blog_footer_info'];
    blog_locale = jsonRes['blog_locale'];
    blog_title = jsonRes['blog_title'];
    blog_url = jsonRes['blog_url'];
    comment_content_placeholder = jsonRes['comment_content_placeholder'];
    comment_custom_style = jsonRes['comment_custom_style'];
    comment_gavatar_default = jsonRes['comment_gavatar_default'];
    email_from_name = jsonRes['email_from_name'];
    email_host = jsonRes['email_host'];
    email_password = jsonRes['email_password'];
    email_protocol = jsonRes['email_protocol'];
    email_username = jsonRes['email_username'];
    oss_qiniu_zone = jsonRes['oss_qiniu_zone'];
    oss_upyun_operator = jsonRes['oss_upyun_operator'];
    oss_upyun_password = jsonRes['oss_upyun_password'];
    seo_keywords = jsonRes['seo_keywords'];
    theme = jsonRes['theme'];
  }

  @override
  String toString() {
    return '{"birthday": $birthday,"comment_page_size": $comment_page_size,"email_ssl_port": $email_ssl_port,"post_index_page_size": $post_index_page_size,"post_summary_length": $post_summary_length,"rss_page_size": $rss_page_size,"api_enabled": $api_enabled,"comment_api_enabled": $comment_api_enabled,"comment_new_need_check": $comment_new_need_check,"comment_new_notice": $comment_new_notice,"comment_pass_notice": $comment_pass_notice,"comment_reply_notice": $comment_reply_notice,"email_enabled": $email_enabled,"is_installed": $is_installed,"spider_disabled": $spider_disabled,"attachment_type": ${attachment_type != null ? '${json.encode(attachment_type)}' : 'null'},"blog_footer_info": ${blog_footer_info != null ? '${json.encode(blog_footer_info)}' : 'null'},"blog_locale": ${blog_locale != null ? '${json.encode(blog_locale)}' : 'null'},"blog_title": ${blog_title != null ? '${json.encode(blog_title)}' : 'null'},"blog_url": ${blog_url != null ? '${json.encode(blog_url)}' : 'null'},"comment_content_placeholder": ${comment_content_placeholder != null ? '${json.encode(comment_content_placeholder)}' : 'null'},"comment_custom_style": ${comment_custom_style != null ? '${json.encode(comment_custom_style)}' : 'null'},"comment_gavatar_default": ${comment_gavatar_default != null ? '${json.encode(comment_gavatar_default)}' : 'null'},"email_from_name": ${email_from_name != null ? '${json.encode(email_from_name)}' : 'null'},"email_host": ${email_host != null ? '${json.encode(email_host)}' : 'null'},"email_password": ${email_password != null ? '${json.encode(email_password)}' : 'null'},"email_protocol": ${email_protocol != null ? '${json.encode(email_protocol)}' : 'null'},"email_username": ${email_username != null ? '${json.encode(email_username)}' : 'null'},"oss_qiniu_zone": ${oss_qiniu_zone != null ? '${json.encode(oss_qiniu_zone)}' : 'null'},"oss_upyun_operator": ${oss_upyun_operator != null ? '${json.encode(oss_upyun_operator)}' : 'null'},"oss_upyun_password": ${oss_upyun_password != null ? '${json.encode(oss_upyun_password)}' : 'null'},"seo_keywords": ${seo_keywords != null ? '${json.encode(seo_keywords)}' : 'null'},"theme": ${theme != null ? '${json.encode(theme)}' : 'null'}}';
  }
}
