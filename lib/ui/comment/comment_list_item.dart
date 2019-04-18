import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:halo/module/comment.dart';

String icon = "https://secure.gravatar.com/avatar/a08917f5098953adef7dbb3f09641b65";

class CommentListItemPage extends StatelessWidget {
  Comment item;

  CommentListItemPage(this.item);

  Color textColor = Color.fromARGB(255, 88, 125, 151);
  Color titleColor = Color.fromARGB(255, 46, 68, 83);
  Color draftColor = Color.fromARGB(255, 219, 158, 37);

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
                backgroundImage: CachedNetworkImageProvider(icon),
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
                        "一位WordPress评论者 对 世界，你好！的评论",
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
                          "前天",
                          style: TextStyle(color: textColor, fontSize: 13),
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    "嗨！这是一条评论。要开始审核、编辑及删除评论，请访问仪表盘的\"评论\"页面。",
                    softWrap: true,
                    maxLines: 2,
                    style: new TextStyle(
                      color: textColor,
                      fontSize: 15,
                    ),
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
