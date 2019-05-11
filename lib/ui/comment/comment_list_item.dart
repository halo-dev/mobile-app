import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:halo/module/comment_entity.dart';
import 'package:halo/util/Utils.dart';

String icon = "https://secure.gravatar.com/avatar/";

class CommentListItemPage extends StatelessWidget {
  CommentContent item;

  CommentListItemPage(this.item);

  Color textColor = Color.fromARGB(255, 88, 125, 151);
  Color titleColor = Color.fromARGB(255, 46, 68, 83);
  Color draftColor = Color.fromARGB(255, 219, 158, 37);

//  static TextTheme textTheme = new Typography(platform: TargetPlatform.android)
//      .black
//      .merge(new TextTheme(body1: new TextStyle(fontSize: 16.0)));
//  static final ThemeData theme =
//  new ThemeData.light().copyWith(textTheme: textTheme);
//  final MarkdownStyleSheet style1 = new MarkdownStyleSheet.fromTheme(theme);

//Color.fromARGB(255, 46, 68, 83)
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: SizedBox(
              width: 50.0,
              height: 50.0,
              child: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider("$icon${item.gavatarMd5}"),
                radius: 60,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "${item.author} 对 ${item.post.title}的评论",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: new TextStyle(
                          color: titleColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                          color: textColor,
                          size: 13,
                        ),
                        const SizedBox(width: 3.0),
                        Text(
                          Utils.getFormattedTime(item.createTime),
                          style: TextStyle(color: textColor, fontSize: 13),
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: MarkdownBody(
                    data: item.content,
//                    styleSheet: style1,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
