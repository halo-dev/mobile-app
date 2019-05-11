import 'dart:convert' show json;

class Site {
  int expired;
  String accessToken;
  String avatar;
  String host;
  String nickname;
  String refreshToken;
  String title;
  String username;

  Site.fromParams(
      {this.expired,
      this.accessToken,
      this.avatar,
      this.host,
      this.nickname,
      this.refreshToken,
      this.title,
      this.username});

  factory Site(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new Site.fromJson(json.decode(jsonStr))
          : new Site.fromJson(jsonStr);

  Site.fromJson(jsonRes) {
    expired = jsonRes['expired'];
    accessToken = jsonRes['accessToken'];
    avatar = jsonRes['avatar'];
    host = jsonRes['host'];
    nickname = jsonRes['nickname'];
    refreshToken = jsonRes['refreshToken'];
    title = jsonRes['title'];
    username = jsonRes['username'];
  }

  @override
  String toString() {
    return '{"expired": $expired,"accessToken": ${accessToken != null ? '${json.encode(accessToken)}' : 'null'},"avatar": ${avatar != null ? '${json.encode(avatar)}' : 'null'},"host": ${host != null ? '${json.encode(host)}' : 'null'},"nickname": ${nickname != null ? '${json.encode(nickname)}' : 'null'},"refreshToken": ${refreshToken != null ? '${json.encode(refreshToken)}' : 'null'},"title": ${title != null ? '${json.encode(title)}' : 'null'},"username": ${username != null ? '${json.encode(username)}' : 'null'}}';
  }
}
