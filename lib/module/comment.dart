import 'dart:convert' show json;

class CommentList {
  List<Comment> list;

  CommentList.fromParams({this.list});

  factory CommentList(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new CommentList.fromJson(json.decode(jsonStr))
          : new CommentList.fromJson(jsonStr);

  CommentList.fromJson(jsonRes) {
    list = jsonRes == null ? null : [];

    for (var listItem in list == null ? [] : jsonRes['list']) {
      list.add(listItem == null ? null : new Comment.fromJson(listItem));
    }
  }

  @override
  String toString() {
    return '{"json_list": $list}';
  }
}

class Comment {
  int id;
  int parentId;
  bool isAdmin;
  String author;
  String content;
  String createTime;
  String email;
  String gavatarMd5;
  String ipAddress;
  String status;
  String userAgent;
  Post post;

  Comment();

  Comment.fromParams(
      {this.id,
      this.parentId,
      this.isAdmin,
      this.author,
      this.content,
      this.createTime,
      this.email,
      this.gavatarMd5,
      this.ipAddress,
      this.status,
      this.userAgent,
      this.post});

  Comment.fromJson(jsonRes) {
    id = jsonRes['id'];
    parentId = jsonRes['parentId'];
    isAdmin = jsonRes['isAdmin'];
    author = jsonRes['author'];
    content = jsonRes['content'];
    createTime = jsonRes['createTime'];
    email = jsonRes['email'];
    gavatarMd5 = jsonRes['gavatarMd5'];
    ipAddress = jsonRes['ipAddress'];
    status = jsonRes['status'];
    userAgent = jsonRes['userAgent'];
    post = jsonRes['post'] == null ? null : new Post.fromJson(jsonRes['post']);
  }

  @override
  String toString() {
    return '{"id": $id,"parentId": $parentId,"isAdmin": $isAdmin,"author": ${author != null ? '${json.encode(author)}' : 'null'},"content": ${content != null ? '${json.encode(content)}' : 'null'},"createTime": ${createTime != null ? '${json.encode(createTime)}' : 'null'},"email": ${email != null ? '${json.encode(email)}' : 'null'},"gavatarMd5": ${gavatarMd5 != null ? '${json.encode(gavatarMd5)}' : 'null'},"ipAddress": ${ipAddress != null ? '${json.encode(ipAddress)}' : 'null'},"status": ${status != null ? '${json.encode(status)}' : 'null'},"userAgent": ${userAgent != null ? '${json.encode(userAgent)}' : 'null'},"post": $post}';
  }
}

class Post {
  int id;
  String createTime;
  String editTime;
  String status;
  String title;
  String type;
  String updateTime;
  String url;

  Post.fromParams(
      {this.id,
      this.createTime,
      this.editTime,
      this.status,
      this.title,
      this.type,
      this.updateTime,
      this.url});

  Post.fromJson(jsonRes) {
    id = jsonRes['id'];
    createTime = jsonRes['createTime'];
    editTime = jsonRes['editTime'];
    status = jsonRes['status'];
    title = jsonRes['title'];
    type = jsonRes['type'];
    updateTime = jsonRes['updateTime'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"id": $id,"createTime": ${createTime != null ? '${json.encode(createTime)}' : 'null'},"editTime": ${editTime != null ? '${json.encode(editTime)}' : 'null'},"status": ${status != null ? '${json.encode(status)}' : 'null'},"title": ${title != null ? '${json.encode(title)}' : 'null'},"type": ${type != null ? '${json.encode(type)}' : 'null'},"updateTime": ${updateTime != null ? '${json.encode(updateTime)}' : 'null'},"url": ${url != null ? '${json.encode(url)}' : 'null'}}';
  }
}
