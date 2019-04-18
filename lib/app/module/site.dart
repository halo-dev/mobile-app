import 'dart:convert' show json;

class Site {
  String account;
  String address;
  String icon;
  String password;
  String title;

  Site.fromParams({this.account, this.address, this.icon, this.password, this.title});

  factory Site(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String ? new Site.fromJson(json.decode(jsonStr)) : new Site.fromJson(jsonStr);

  Site.fromJson(jsonRes) {
    account = jsonRes['account'];
    address = jsonRes['address'];
    icon = jsonRes['icon'];
    password = jsonRes['password'];
    title = jsonRes['title'];
  }

  @override
  String toString() {
    return '{"account": ${account != null ? '${json.encode(account)}' : 'null'},"address": ${address != null ? '${json.encode(address)}' : 'null'},"icon": ${icon != null ? '${json.encode(icon)}' : 'null'},"password": ${password != null ? '${json.encode(password)}' : 'null'},"title": ${title != null ? '${json.encode(title)}' : 'null'}}';
  }
}
