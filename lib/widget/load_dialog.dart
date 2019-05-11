import 'package:flutter/material.dart';

class LoadingDialog extends Dialog {
  String text;
  bool cancelAble;

  LoadingDialog({Key key, @required this.text, bool cancelAble = true})
      : super(key: key) {
    this.cancelAble = cancelAble;
    this.text = text;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (cancelAble) Navigator.of(context).pop(false);
      },
      child: Material(
        //创建透明层
        type: MaterialType.transparency, //透明类型
        child: new Center(
          //保证控件居中效果
          child: new SizedBox(
            width: 100.0,
            height: 100.0,
            child: new Container(
              decoration: ShapeDecoration(
                color: Color.fromARGB(125, 255, 255, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              child: new Column(
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
