import 'dart:convert' show json;

class TagList {
  List<Tag> list;

  TagList.fromParams({this.list});

  factory TagList(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new TagList.fromJson(json.decode(jsonStr))
          : new TagList.fromJson(jsonStr);

  TagList.fromJson(jsonRes) {
    list = jsonRes == null ? null : [];
    for (var listItem in list == null ? [] : jsonRes) {
      list.add(listItem == null ? null : new Tag.fromJson(listItem));
    }
  }

  @override
  String toString() {
    return '{"json_list": $list}';
  }
}

class Tag {
  int id;
  String name;
  String slugName;

  Tag.fromParams({this.id, this.name, this.slugName});

  Tag.fromJson(jsonRes) {
    id = jsonRes['id'];
    name = jsonRes['name'];
    slugName = jsonRes['slugName'];
  }

  @override
  String toString() {
    return '{"id": $id,"name": ${name != null ? '${json.encode(name)}' : 'null'},"slugName": ${slugName != null ? '${json.encode(slugName)}' : 'null'}}';
  }
}
