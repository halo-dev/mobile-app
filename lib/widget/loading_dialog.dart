import 'package:flutter/material.dart';
import 'package:halo/app/config.dart';

loading({text = "加载中"}) {
  return content(Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      new CircularProgressIndicator(),
      new Padding(
        padding: const EdgeInsets.only(
          top: 20.0,
        ),
        child: new Text(
          text,
          style: new TextStyle(fontSize: 12.0),
        ),
      ),
    ],
  ));
}

loadingFail({text = "加载失败，请重试"}) {
  return content(Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Image.asset(
        "assest/images/loading_fail.png",
        width: 34,
        height: 34,
      ),
      new Padding(
        padding: const EdgeInsets.only(
          top: 20.0,
        ),
        child: new Text(
          text,
          style: new TextStyle(fontSize: 12.0),
        ),
      ),
    ],
  ));
}

empty({text = "暂无数据"}) {
  return content(Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Image.asset(
        "assest/images/empty_box.png",
        width: 34,
        height: 34,
      ),
      new Padding(
        padding: const EdgeInsets.only(
          top: 20.0,
        ),
        child: new Text(
          text,
          style: new TextStyle(fontSize: 12.0),
        ),
      ),
    ],
  ));
}

content(content) {
  return SizedBox(
    width: 100.0,
    height: 100.0,
    child: new Container(
      decoration: ShapeDecoration(
        color: Config.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
      ),
      child: content,
    ),
  );
}

loadWithStatus(int status) {
  return (status == null || status == 0)
      ? loading(text: "加载中")
      : status == 200 ? empty() : loadingFail();
}
