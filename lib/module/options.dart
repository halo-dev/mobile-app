import 'dart:convert' show json;

class Options {
  int birthday;
  int comment_page_size;
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
  String attachment_type;
  String blog_title;
  String blog_url;
  String comment_gavatar_default;
  String oss_qiniu_zone;
  String theme;

  Options.fromParams(
      {this.birthday,
      this.comment_page_size,
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
      this.attachment_type,
      this.blog_title,
      this.blog_url,
      this.comment_gavatar_default,
      this.oss_qiniu_zone,
      this.theme});

  factory Options(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new Options.fromJson(json.decode(jsonStr))
          : new Options.fromJson(jsonStr);

  Options.fromJson(jsonRes) {
    birthday = jsonRes['birthday'];
    comment_page_size = jsonRes['comment_page_size'];
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
    attachment_type = jsonRes['attachment_type'];
    blog_title = jsonRes['blog_title'];
    blog_url = jsonRes['blog_url'];
    comment_gavatar_default = jsonRes['comment_gavatar_default'];
    oss_qiniu_zone = jsonRes['oss_qiniu_zone'];
    theme = jsonRes['theme'];
  }

  @override
  String toString() {
    return '{"birthday": $birthday,"comment_page_size": $comment_page_size,"post_index_page_size": $post_index_page_size,"post_summary_length": $post_summary_length,"rss_page_size": $rss_page_size,"api_enabled": $api_enabled,"comment_api_enabled": $comment_api_enabled,"comment_new_need_check": $comment_new_need_check,"comment_new_notice": $comment_new_notice,"comment_pass_notice": $comment_pass_notice,"comment_reply_notice": $comment_reply_notice,"email_enabled": $email_enabled,"is_installed": $is_installed,"attachment_type": ${attachment_type != null ? '${json.encode(attachment_type)}' : 'null'},"blog_title": ${blog_title != null ? '${json.encode(blog_title)}' : 'null'},"blog_url": ${blog_url != null ? '${json.encode(blog_url)}' : 'null'},"comment_gavatar_default": ${comment_gavatar_default != null ? '${json.encode(comment_gavatar_default)}' : 'null'},"oss_qiniu_zone": ${oss_qiniu_zone != null ? '${json.encode(oss_qiniu_zone)}' : 'null'},"theme": ${theme != null ? '${json.encode(theme)}' : 'null'}}';
  }
}
