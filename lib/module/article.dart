import 'dart:convert' show json;

import 'package:halo/module/category_list.dart';
import 'package:halo/module/tag_list.dart';

class Post {
  int number;
  int numberOfElements;
  int size;
  int totalElements;
  int totalPages;
  bool empty;
  bool first;
  bool last;
  List<Content> content;
  Pageable pageable;
  Sort sort;

  Post.fromParams(
      {this.number,
      this.numberOfElements,
      this.size,
      this.totalElements,
      this.totalPages,
      this.empty,
      this.first,
      this.last,
      this.content,
      this.pageable,
      this.sort});

  factory Post(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new Post.fromJson(json.decode(jsonStr))
          : new Post.fromJson(jsonStr);

  Post.fromJson(jsonRes) {
    number = jsonRes['number'];
    numberOfElements = jsonRes['numberOfElements'];
    size = jsonRes['size'];
    totalElements = jsonRes['totalElements'];
    totalPages = jsonRes['totalPages'];
    empty = jsonRes['empty'];
    first = jsonRes['first'];
    last = jsonRes['last'];
    content = jsonRes['content'] == null ? null : [];

    for (var contentItem in content == null ? [] : jsonRes['content']) {
      content
          .add(contentItem == null ? null : new Content.fromJson(contentItem));
    }

    pageable = jsonRes['pageable'] == null
        ? null
        : new Pageable.fromJson(jsonRes['pageable']);
    sort = jsonRes['sort'] == null ? null : new Sort.fromJson(jsonRes['sort']);
  }

  @override
  String toString() {
    return '{"number": $number,"numberOfElements": $numberOfElements,"size": $size,"totalElements": $totalElements,"totalPages": $totalPages,"empty": $empty,"first": $first,"last": $last,"content": $content,"pageable": $pageable,"sort": $sort}';
  }
}

class Sort {
  List<String> sort;

  Sort.fromParams({this.sort});

  Sort.fromJson(jsonRes) {
    sort = jsonRes['sort'] == null ? null : [];

    for (var sortItem in sort == null ? [] : jsonRes['sort']) {
      sort.add(sortItem);
    }
  }

  @override
  String toString() {
    return '{"sort": $sort}';
  }
}

class Pageable {
  int page;
  int size;
  List<String> sort;

  Pageable.fromParams({this.page, this.size, this.sort});

  Pageable.fromJson(jsonRes) {
    page = jsonRes['page'];
    size = jsonRes['size'];
    sort = jsonRes['sort'] == null ? null : [];

    for (var sortItem in sort == null ? [] : jsonRes['sort']) {
      sort.add(sortItem);
    }
  }

  @override
  String toString() {
    return '{"page": $page,"size": $size,"sort": $sort}';
  }
}

class Content {
  int commentCount;
  int id;
  int likes;
  int topPriority;
  int visits;
  bool disallowComment;
  String createFrom;
  int createTime;
  int editTime;
  String status;
  String summary;
  String template;
  String thumbnail;
  String title;
  String type;
  int updateTime;
  String url;
  List<Category> categories;
  List<Tag> tags;

  Content();

  Content.fromParams(
      {this.commentCount,
      this.id,
      this.likes,
      this.topPriority,
      this.visits,
      this.disallowComment,
      this.createFrom,
      this.createTime,
      this.editTime,
      this.status,
      this.summary,
      this.template,
      this.thumbnail,
      this.title,
      this.type,
      this.updateTime,
      this.url,
      this.categories,
      this.tags});

  Content.fromJson(jsonRes) {
    commentCount = jsonRes['commentCount'];
    id = jsonRes['id'];
    likes = jsonRes['likes'];
    topPriority = jsonRes['topPriority'];
    visits = jsonRes['visits'];
    disallowComment = jsonRes['disallowComment'];
    createFrom = jsonRes['createFrom'];
    createTime = jsonRes['createTime'];
    editTime = jsonRes['editTime'];
    status = jsonRes['status'];
    summary = jsonRes['summary'];
    template = jsonRes['template'];
    thumbnail = jsonRes['thumbnail'];
    title = jsonRes['title'];
    type = jsonRes['type'];
    updateTime = jsonRes['updateTime'];
    url = jsonRes['url'];
    categories = jsonRes['categories'] == null ? null : [];

    for (var categoriesItem
        in categories == null ? [] : jsonRes['categories']) {
      categories.add(categoriesItem == null
          ? null
          : new Category.fromJson(categoriesItem));
    }

    tags = jsonRes['tags'] == null ? null : [];

    for (var tagsItem in tags == null ? [] : jsonRes['tags']) {
      tags.add(tagsItem == null ? null : new Tag.fromJson(tagsItem));
    }
  }

  @override
  String toString() {
    return '{"commentCount": $commentCount,"id": $id,"likes": $likes,"topPriority": $topPriority,"visits": $visits,"disallowComment": $disallowComment,"createFrom": ${createFrom != null ? '${json.encode(createFrom)}' : 'null'},"createTime": ${createTime != null ? '${json.encode(createTime)}' : 'null'},"editTime": ${editTime != null ? '${json.encode(editTime)}' : 'null'},"status": ${status != null ? '${json.encode(status)}' : 'null'},"summary": ${summary != null ? '${json.encode(summary)}' : 'null'},"template": ${template != null ? '${json.encode(template)}' : 'null'},"thumbnail": ${thumbnail != null ? '${json.encode(thumbnail)}' : 'null'},"title": ${title != null ? '${json.encode(title)}' : 'null'},"type": ${type != null ? '${json.encode(type)}' : 'null'},"updateTime": ${updateTime != null ? '${json.encode(updateTime)}' : 'null'},"url": ${url != null ? '${json.encode(url)}' : 'null'},"categories": $categories,"tags": $tags}';
  }
}
