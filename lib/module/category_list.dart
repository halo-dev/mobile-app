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
    return '{"list": $list}';
  }
}

class Category {
  int id;
  int parentId;
  String description;
  String name;
  String slugName;
  List<Category> children;

  Category.fromParams(
      {this.id, this.parentId, this.description, this.name, this.slugName, this.children});

  Category.fromJson(jsonRes) {
    id = jsonRes['id'];
    parentId = jsonRes['parentId'];
    description = jsonRes['description'];
    name = jsonRes['name'];
    slugName = jsonRes['slugName'];
    children = jsonRes['children'] == null ? null : [];

    for (var childrenItem in children == null ? [] : jsonRes['children']) {
      children.add(childrenItem == null ? null : new Category.fromJson(childrenItem));
    }
  }

  @override
  String toString() {
    return '{"id": $id,"parentId": $parentId,"description": ${description != null ? '${json.encode(description)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"slugName": ${slugName != null ? '${json.encode(slugName)}' : 'null'},"children": $children}';
  }
}
