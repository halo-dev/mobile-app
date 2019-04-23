import 'dart:convert' show json;

class CategoryList {
  List<Category> list;

  CategoryList.fromParams({this.list});

  factory CategoryList(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new CategoryList.fromJson(json.decode(jsonStr))
          : new CategoryList.fromJson(jsonStr);

  CategoryList.fromJson(jsonRes) {
    list = jsonRes == null ? null : [];

    for (var listItem in list == null ? [] : jsonRes) {
      list.add(listItem == null ? null : new Category.fromJson(listItem));
    }
  }

  @override
  String toString() {
    return '{"json_list": $list}';
  }
}

class Category {
  int createTime;
  int id;
  int parentId;
  int updateTime;
  bool deleted;
  String description;
  String name;
  String slugName;

  Category.fromParams(
      {this.createTime,
      this.id,
      this.parentId,
      this.updateTime,
      this.deleted,
      this.description,
      this.name,
      this.slugName});

  Category.fromJson(jsonRes) {
    createTime = jsonRes['createTime'];
    id = jsonRes['id'];
    parentId = jsonRes['parentId'];
    updateTime = jsonRes['updateTime'];
    deleted = jsonRes['deleted'];
    description = jsonRes['description'];
    name = jsonRes['name'];
    slugName = jsonRes['slugName'];
  }

  @override
  String toString() {
    return '{"createTime": $createTime,"id": $id,"parentId": $parentId,"updateTime": $updateTime,"deleted": $deleted,"description": ${description != null ? '${json.encode(description)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"slugName": ${slugName != null ? '${json.encode(slugName)}' : 'null'}}';
  }
}
