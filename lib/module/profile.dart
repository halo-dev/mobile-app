import 'dart:convert' show json;

class Profile {
  int id;
  String avatar;
  String createTime;
  String description;
  String email;
  String nickname;
  String updateTime;
  String username;

  Profile.fromParams(
      {this.id,
      this.avatar,
      this.createTime,
      this.description,
      this.email,
      this.nickname,
      this.updateTime,
      this.username});

  factory Profile(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new Profile.fromJson(json.decode(jsonStr))
          : new Profile.fromJson(jsonStr);

  Profile.fromJson(jsonRes) {
    id = jsonRes['id'];
    avatar = jsonRes['avatar'];
    createTime = jsonRes['createTime'];
    description = jsonRes['description'];
    email = jsonRes['email'];
    nickname = jsonRes['nickname'];
    updateTime = jsonRes['updateTime'];
    username = jsonRes['username'];
  }

  @override
  String toString() {
    return '{"id": $id,"avatar": ${avatar != null ? '${json.encode(avatar)}' : 'null'},"createTime": ${createTime != null ? '${json.encode(createTime)}' : 'null'},"description": ${description != null ? '${json.encode(description)}' : 'null'},"email": ${email != null ? '${json.encode(email)}' : 'null'},"nickname": ${nickname != null ? '${json.encode(nickname)}' : 'null'},"updateTime": ${updateTime != null ? '${json.encode(updateTime)}' : 'null'},"username": ${username != null ? '${json.encode(username)}' : 'null'}}';
  }
}
