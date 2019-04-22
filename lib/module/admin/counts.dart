import 'dart:convert' show json;

class Counts {
  int attachmentCount;
  int commentCount;
  int establishDays;
  int likeCount;
  int linkCount;
  int postCount;
  int visitCount;

  Counts.fromParams(
      {this.attachmentCount,
      this.commentCount,
      this.establishDays,
      this.likeCount,
      this.linkCount,
      this.postCount,
      this.visitCount});

  factory Counts(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new Counts.fromJson(json.decode(jsonStr))
          : new Counts.fromJson(jsonStr);

  Counts.fromJson(jsonRes) {
    attachmentCount = jsonRes['attachmentCount'];
    commentCount = jsonRes['commentCount'];
    establishDays = jsonRes['establishDays'];
    likeCount = jsonRes['likeCount'];
    linkCount = jsonRes['linkCount'];
    postCount = jsonRes['postCount'];
    visitCount = jsonRes['visitCount'];
  }

  @override
  String toString() {
    return '{"attachmentCount": $attachmentCount,"commentCount": $commentCount,"establishDays": $establishDays,"likeCount": $likeCount,"linkCount": $linkCount,"postCount": $postCount,"visitCount": $visitCount}';
  }
}
