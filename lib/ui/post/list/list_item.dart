import 'package:flutter/material.dart';
import 'package:halo/module/article.dart';

class ListItemPage extends StatelessWidget {
  Content item;

  ListItemPage(this.item);

  Color textColor = Color.fromARGB(255, 0, 135, 190);
  Color contentColor = Color.fromARGB(255, 46, 68, 83);
  Color draftColor = Color.fromARGB(255, 219, 158, 37);

//Color.fromARGB(255, 46, 68, 83)
  @override
  Widget build(BuildContext context) {
    return Card(
//      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      margin: EdgeInsets.all(5),
      elevation: 2,
      child: new Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '世界,你好',
                  style: new TextStyle(
                    color: contentColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      '欢迎使用WordPress，这是你的第一篇文章。删除或编辑它，然后开始写作吧！',
                      softWrap: true,
                      maxLines: 2,
                      style: new TextStyle(
                        color: contentColor,
                        fontSize: 16,
                      ),
                    )),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Icon(
                      Icons.access_time,
                      color: contentColor,
                      size: 13,
                    ),
                    const SizedBox(width: 3.0),
                    Text(
                      "前天",
                      style: TextStyle(color: contentColor, fontSize: 13),
                    ),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Icon(
                          Icons.description,
                          size: 13,
                          color: draftColor,
                        ),
                        const SizedBox(width: 3.0),
                        Text(
                          "草稿",
                          style: TextStyle(color: draftColor, fontSize: 13),
                        ),
                      ],
                    )),
              ],
            ),
          ),
          new Container(
            // 盒子样式
            padding: EdgeInsets.only(right: 10),
            color: Color.fromARGB(255, 243, 246, 248),
            child: Row(
              children: [
                _buildBtnIcon(
                    _buildIcon(
                      Icons.edit,
                    ),
                    "编辑",
                    () {}),
                _buildBtnIcon(
                    Image.asset(
                      "assest/images/image_view.png",
                      width: 18,
                      height: 18,
                      color: textColor,
                    ),
                    "查看",
                    null),
                _buildBtnIcon(
                    _buildIcon(
                      Icons.cloud_upload,
                    ),
                    "提交",
                    null),
                _buildBtnIcon(
                    _buildIcon(
                      Icons.delete,
                    ),
                    "放入回收站",
                    () {}),
//                _buildBtnIcon(
//                    _buildIcon(
//                      Icons.delete,
//                    ),
//                    "删除",
//                    null),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildIcon(icon) {
    return Icon(
      Icons.delete,
      size: 18,
      color: textColor,
    );
  }

  Widget _buildBtnIcon(icon, text, callBack) {
    return Expanded(
        child: InkWell(
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    icon,
                    const SizedBox(width: 3.0),
                    Text(
                      text,
                      style: TextStyle(color: textColor, fontSize: 13),
                    ),
                  ],
                )),
            onTap: callBack));
  }
}
