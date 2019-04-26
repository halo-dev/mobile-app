import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:halo/app/config.dart';
import 'package:halo/app/provide.dart';
import 'package:halo/ui/post/edit/edit_post_module.dart';

class SetPostOptionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SetPostOptionPageView();
  }
}

class _SetPostOptionPageView extends State<SetPostOptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Config.background,
        appBar: AppBar(
          title: Text("文章设置"),
        ),
        body: buildBody(context));
  }

  Widget buildBody(BuildContext context) {
    return Provide<EditPostModule>(builder: (context, child, mode) {
      List<Widget> widgets = List();
      widgets.add(_buildSelectMenu(
          createItem("状态", mode.getStatus(), () {}), _buildSelectItem(status), (data) {}));

      ///createItem("状态", mode.getStatus(), () {})
//          createItem("状态", "发布", () {}));
      widgets.add(Divider(height: 1));
      widgets.add(createItem("密码", "未设置", () {}));
      widgets.add(Divider(height: 15, color: Colors.transparent));
      widgets.add(
        Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(24, 15, 24, 0),
            child: Text(
              "分类&标签",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Config.lightColor),
            )),
      );
      widgets.add(createItem("分类", "未设置", () {}));
      widgets.add(Divider(height: 1));
      widgets.add(createItem("标签", "未设置", () {}));
      widgets.add(Divider(height: 15, color: Colors.transparent));
      widgets.add(
        Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(24, 15, 24, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "推荐图片",
                  style: TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w600, color: Config.lightColor),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: FlatButton(
                        color: Config.lightColor,
                        onPressed: () {},
                        child: Text(
                          "选择推荐图片",
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        )))
              ],
            )),
      );

      widgets.add(Divider(height: 15, color: Colors.transparent));
      widgets.add(
        Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(24, 15, 24, 0),
            child: Text("更多选项",
                style: TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600, color: Config.lightColor))),
      );
      widgets.add(createItem("slug", "未设置", () {}));
      widgets.add(Divider(height: 1));
      widgets.add(createItem("是否允许评论", "未设置", () {}));
      widgets.add(Divider(height: 1));
      widgets.add(createItem("自定义模板", "未设置", () {}));
      return ListView.builder(
          itemCount: widgets.length,
          itemBuilder: (BuildContext context, int index) {
            return widgets[index];
          });
    });
  }

  Widget createItem(title, subtitle, Function callBack) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(24, 13, 24, 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 15, color: Config.fontColor),
          ),
          Text(
            subtitle,
            style: TextStyle(fontSize: 13, color: Config.fontLightColor),
          ),
        ],
      ),
    );
  }

  TextStyle style = TextStyle(fontSize: 16, color: Color.fromARGB(255, 102, 142, 170));

  _openNew(BuildContext context) {
//    pushToNewPage(context, EditPostPage());
  }

//  _buildStatus(BuildContext context) {
//    AlertContentDialog(context,"状态",(){},);
//  }
//
//  _buildSelect(){
//
//  }

  _buildSelectMenu(hit, itemList, cheang) {
    return Container(
      color: Colors.white,
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          iconSize: 0,
          items: itemList,
          hint: hit,
          isExpanded: true,
          onChanged: (data) {},
        ),
      ),
    );
  }

  _buildSelectItem(HashMap<dynamic, String> map) {
    List<DropdownMenuItem> list = List();
    map.forEach((key, value) {
      list.add(DropdownMenuItem(
          value: key,
          child: Container(
            child: Text(value),
            width: MediaQuery.of(context).size.width - 24,
          )));
    });
    return list;
  }
}
