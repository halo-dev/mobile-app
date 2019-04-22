import 'dart:convert' show json;

class Site {
  String account;
  String address;
  String avatar;
  String password;
  String title;

  Site.fromParams({this.account, this.address, this.avatar, this.password, this.title});

  factory Site(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String ? new Site.fromJson(json.decode(jsonStr)) : new Site.fromJson(jsonStr);

  Site.fromJson(jsonRes) {
    account = jsonRes['account'];
    address = jsonRes['address'];
    avatar = jsonRes['avatar'];
    password = jsonRes['password'];
    title = jsonRes['title'];
  }

  @override
  String toString() {
    return '{"account": ${account != null ? '${json.encode(account)}' : 'null'},"address": ${address != null ? '${json.encode(address)}' : 'null'},"avatar": ${avatar != null ? '${json.encode(avatar)}' : 'null'},"password": ${password != null ? '${json.encode(password)}' : 'null'},"title": ${title != null ? '${json.encode(title)}' : 'null'}}';
  }
}
