import 'dart:convert' show json;

class PostParam {
  String type;
  int createTime;
  int editTime;
  int id;
  int likes;
  int topPriority;
  int updateTime;
  int visits;
  bool disallowComment;
  String createFrom;
  String formatContent;
  String originalContent;
  String status;
  String summary;
  String password;
  String template;
  String thumbnail;
  String title;
  String url;
  List<int> categoryIds;
  List<int> tagIds;

  PostParam.fromParams(
      {this.type,
      this.createTime,
      this.editTime,
      this.id,
      this.likes,
      this.topPriority,
      this.updateTime,
      this.visits,
      this.disallowComment,
      this.createFrom,
      this.formatContent,
      this.originalContent,
      this.password,
      this.status,
      this.summary,
      this.template,
      this.thumbnail,
      this.title,
      this.url,
      this.categoryIds,
      this.tagIds});

  factory PostParam(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new PostParam.fromJson(json.decode(jsonStr))
          : new PostParam.fromJson(jsonStr);

  PostParam.fromJson(jsonRes) {
    type = jsonRes['type'];
    createTime = jsonRes['createTime'];
    editTime = jsonRes['editTime'];
    id = jsonRes['id'];
    likes = jsonRes['likes'];
    topPriority = jsonRes['topPriority'];
    updateTime = jsonRes['updateTime'];
    visits = jsonRes['visits'];
    disallowComment = jsonRes['disallowComment'];
    createFrom = jsonRes['createFrom'];
    formatContent = jsonRes['formatContent'];
    originalContent = jsonRes['originalContent'];
    password = jsonRes['password'];
    status = jsonRes['status'];
    summary = jsonRes['summary'];
    template = jsonRes['template'];
    thumbnail = jsonRes['thumbnail'];
    title = jsonRes['title'];
    url = jsonRes['url'];
    categoryIds = jsonRes['categoryIds'] == null ? null : [];

    for (var categoryIdsItem in categoryIds == null ? [] : jsonRes['categoryIds']) {
      categoryIds.add(categoryIdsItem);
    }

    tagIds = jsonRes['tagIds'] == null ? null : [];

    for (var tagIdsItem in tagIds == null ? [] : jsonRes['tagIds']) {
      tagIds.add(tagIdsItem);
    }
  }

  @override
  String toString() {
    return '{"type": ${type != null ? '${json.encode(type)}' : 'null'},"createTime": $createTime,"editTime": $editTime,"id": $id,"likes": $likes,"topPriority": $topPriority,"updateTime": $updateTime,"visits": $visits,"disallowComment": $disallowComment,"password": ${password != null ? '${json.encode(password)}' : 'null'},"createFrom": ${createFrom != null ? '${json.encode(createFrom)}' : 'null'},"formatContent": ${formatContent != null ? '${json.encode(formatContent)}' : 'null'},"originalContent": ${originalContent != null ? '${json.encode(originalContent)}' : 'null'},"status": ${status != null ? '${json.encode(status)}' : 'null'},"summary": ${summary != null ? '${json.encode(summary)}' : 'null'},"template": ${template != null ? '${json.encode(template)}' : 'null'},"thumbnail": ${thumbnail != null ? '${json.encode(thumbnail)}' : 'null'},"title": ${title != null ? '${json.encode(title)}' : 'null'},"url": ${url != null ? '${json.encode(url)}' : 'null'},"categoryIds": $categoryIds,"tagIds": $tagIds}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['summary'] = this.summary;
    data['template'] = this.template;
    data['thumbnail'] = this.thumbnail;
    data['disallowComment'] = this.disallowComment;
    data['tagIds'] = this.tagIds;
    data['updateTime'] = this.updateTime;
    data['editTime'] = this.editTime;
    data['title'] = this.title;
    data['type'] = this.type;
    data['url'] = this.url;
    data['createFrom'] = this.createFrom;
    data['visits'] = this.visits;
    data['categoryIds'] = this.categoryIds;
    data['createTime'] = this.createTime;
    data['topPriority'] = this.topPriority;
    data['password'] = this.password;
    data['id'] = this.id;
    data['formatContent'] = this.formatContent;
    data['originalContent'] = this.originalContent;
    data['status'] = this.status;
    data['likes'] = this.likes;
    return data;
  }
}
