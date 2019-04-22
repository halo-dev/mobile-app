import 'dart:convert' show json;

import 'package:halo/util/string_util.dart';

class Profile {
  int createTime;
  int id;
  int updateTime;
  String avatar;
  String description;
  String email;
  String nickname;
  String username;

  String getNick() {
    if (isEmpty(nickname)) {
      return username;
    } else
      return nickname;
  }

  Profile.fromParams(
      {this.createTime,
      this.id,
      this.updateTime,
      this.avatar,
      this.description,
      this.email,
      this.nickname,
      this.username});

  factory Profile(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new Profile.fromJson(json.decode(jsonStr))
          : new Profile.fromJson(jsonStr);

  Profile.fromJson(jsonRes) {
    createTime = jsonRes['createTime'];
    id = jsonRes['id'];
    updateTime = jsonRes['updateTime'];
    avatar = jsonRes['avatar'];
    description = jsonRes['description'];
    email = jsonRes['email'];
    nickname = jsonRes['nickname'];
    username = jsonRes['username'];
  }

  @override
  String toString() {
    return '{"createTime": $createTime,"id": $id,"updateTime": $updateTime,"avatar": ${avatar != null ? '${json.encode(avatar)}' : 'null'},"description": ${description != null ? '${json.encode(description)}' : 'null'},"email": ${email != null ? '${json.encode(email)}' : 'null'},"nickname": ${nickname != null ? '${json.encode(nickname)}' : 'null'},"username": ${username != null ? '${json.encode(username)}' : 'null'}}';
  }
}
