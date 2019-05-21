import 'dart:convert' show json;

class ThemesList {
  List<Themes> list;

  ThemesList.fromParams({this.list});

  factory ThemesList(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new ThemesList.fromJson(json.decode(jsonStr))
          : new ThemesList.fromJson(jsonStr);

  ThemesList.fromJson(jsonRes) {
    list = jsonRes == null ? null : [];

    for (var listItem in list == null ? [] : jsonRes) {
      list.add(listItem == null ? null : new Themes.fromJson(listItem));
    }
  }

  @override
  String toString() {
    return '{"json_list": $list}';
  }
}

class Themes {
  String description;
  String logo;
  bool activated;
  bool hasOptions;
  String folderName;
  String id;
  String name;
  String screenshots;
  String themePath;
  String version;
  String website;
  Author author;

  Themes.fromParams(
      {this.description,
      this.logo,
      this.activated,
      this.hasOptions,
      this.folderName,
      this.id,
      this.name,
      this.screenshots,
      this.themePath,
      this.version,
      this.website,
      this.author});

  Themes.fromJson(jsonRes) {
    description = jsonRes['description'];
    logo = jsonRes['logo'];
    activated = jsonRes['activated'];
    hasOptions = jsonRes['hasOptions'];
    folderName = jsonRes['folderName'];
    id = jsonRes['id'];
    name = jsonRes['name'];
    screenshots = jsonRes['screenshots'];
    themePath = jsonRes['themePath'];
    version = jsonRes['version'];
    website = jsonRes['website'];
    author = jsonRes['author'] == null ? null : new Author.fromJson(jsonRes['author']);
  }

  @override
  String toString() {
    return '{"description": ${description != null ? '${json.encode(description)}' : 'null'},"logo": ${logo != null ? '${json.encode(logo)}' : 'null'},"activated": $activated,"hasOptions": $hasOptions,"folderName": ${folderName != null ? '${json.encode(folderName)}' : 'null'},"id": ${id != null ? '${json.encode(id)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"screenshots": ${screenshots != null ? '${json.encode(screenshots)}' : 'null'},"themePath": ${themePath != null ? '${json.encode(themePath)}' : 'null'},"version": ${version != null ? '${json.encode(version)}' : 'null'},"website": ${website != null ? '${json.encode(website)}' : 'null'},"author": $author}';
  }
}

class Author {
  String avatar;
  String name;
  String website;

  Author.fromParams({this.avatar, this.name, this.website});

  Author.fromJson(jsonRes) {
    avatar = jsonRes['avatar'];
    name = jsonRes['name'];
    website = jsonRes['website'];
  }

  @override
  String toString() {
    return '{"avatar": ${avatar != null ? '${json.encode(avatar)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"website": ${website != null ? '${json.encode(website)}' : 'null'}}';
  }
}
