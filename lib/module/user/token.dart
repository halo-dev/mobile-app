import 'dart:convert' show json;

class Token {
  int expired_in;
  String access_token;
  String refresh_token;

  Token.fromParams({this.expired_in, this.access_token, this.refresh_token});

  factory Token(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new Token.fromJson(json.decode(jsonStr))
          : new Token.fromJson(jsonStr);

  Token.fromJson(jsonRes) {
    expired_in = jsonRes['expired_in'];
    access_token = jsonRes['access_token'];
    refresh_token = jsonRes['refresh_token'];
  }

  @override
  String toString() {
    return '{"expired_in": $expired_in,"access_token": ${access_token != null ? '${json.encode(access_token)}' : 'null'},"refresh_token": ${refresh_token != null ? '${json.encode(refresh_token)}' : 'null'}}';
  }
}
