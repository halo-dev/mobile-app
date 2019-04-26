import 'dart:convert' show json;

class PostParam {
  int topPriority;
  bool disallowComment;
  String createFrom;
  String originalContent;
  String password;
  String status;
  String template;
  String thumbnail;
  String title;
  String url;
  List<int> categoryIds;
  List<int> tagIds;

  PostParam.fromParams(
      {this.topPriority,
      this.disallowComment,
      this.createFrom,
      this.originalContent,
      this.password,
      this.status,
      this.template,
      this.thumbnail,
      this.title,
      this.url,
      this.categoryIds,
      this.tagIds});

//  factory PostParam(jsonStr) => jsonStr == null
//      ? null
//      : jsonStr is String
//          ? new PostParam.fromJson(json.decode(jsonStr))
//          : new PostParam.fromJson(jsonStr);

  PostParam();

  PostParam.fromJson(jsonRes) {
    topPriority = jsonRes['topPriority'];
    disallowComment = jsonRes['disallowComment'];
    createFrom = jsonRes['createFrom'];
    originalContent = jsonRes['originalContent'];
    password = jsonRes['password'];
    status = jsonRes['status'];
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
    return '{"topPriority": $topPriority,"disallowComment": $disallowComment,"createFrom": ${createFrom != null ? '${json.encode(createFrom)}' : 'null'},"originalContent": ${originalContent != null ? '${json.encode(originalContent)}' : 'null'},"password": ${password != null ? '${json.encode(password)}' : 'null'},"status": ${status != null ? '${json.encode(status)}' : 'null'},"template": ${template != null ? '${json.encode(template)}' : 'null'},"thumbnail": ${thumbnail != null ? '${json.encode(thumbnail)}' : 'null'},"title": ${title != null ? '${json.encode(title)}' : 'null'},"url": ${url != null ? '${json.encode(url)}' : 'null'},"categoryIds": $categoryIds,"tagIds": $tagIds}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createFrom'] = this.createFrom;
    data['template'] = this.template;
    data['categoryIds'] = this.categoryIds;
    data['disallowComment'] = this.disallowComment;
    data['password'] = this.password;
    data['thumbnail'] = this.thumbnail;
    data['topPriority'] = this.topPriority;
    data['tagIds'] = this.tagIds;
    data['title'] = this.title;
    data['originalContent'] = this.originalContent;
    data['url'] = this.url;
    data['status'] = this.status;
    return data;
  }
}
