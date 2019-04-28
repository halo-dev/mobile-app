import 'package:flutter/material.dart';
import 'package:halo/app/config.dart';
import 'package:halo/app/provide.dart';
import 'package:halo/ui/post/edit/edit_post_module.dart';
import 'package:halo/ui/post/edit/show_label.dart';
import 'package:halo/ui/tag/tag_manager_module.dart';
import 'package:halo/util/Utils.dart';
import 'package:halo/widget/login_text_field.dart';

class SelectCategoryPage extends StatelessWidget {
  final TextEditingController _tagCtl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Provide.value<TagListModule>(context).updateList(context);
    return Scaffold(
        backgroundColor: Config.background,
        appBar: AppBar(
          title: Text("文章分类"),
        ),
        body: buildBody(context));
  }

  buildBody(BuildContext context) {
    List<Widget> widgets = List()
      ..add(Card(
        elevation: 5,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(24, 10, 14, 3),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "添加新标签",
                style:
                    TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Config.lightColor),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                      child: Container(
                    child: loginTextField("标签名称", _tagCtl, null),
                    margin: EdgeInsets.only(bottom: 8),
                  )),
                  IconButton(
                    icon: Image.asset("assest/images/add_label.png",
                        width: 25, height: 25, color: Config.lightColor),
                    onPressed: () {
                      if (isNotEmpty(_tagCtl.text)) {
                        Provide.value<TagListModule>(context).create(_tagCtl.text, "");
                        _tagCtl.text = "";
                      }
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ))
      ..add(SizedBox(
        height: 5,
      ))
      ..add(Card(
        elevation: 5,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(24, 10, 14, 3),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: Utils.getWidth(context) - 38),
              Text(
                "已经选择的标签",
                style:
                    TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Config.lightColor),
              ),
              Provide<EditPostModule>(builder: (context, child, mode) {
                ///对tag进行检测
                return buildChildren(mode.selectTag, context,
                    delete: false,
                    click: (tag) => Provide.value<EditPostModule>(context).deleteTagSelect(tag));
              })
            ],
          ),
        ),
      ))
      ..add(SizedBox(
        height: 5,
      ))
      ..add(Card(
        elevation: 5,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(24, 10, 14, 3),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: Utils.getWidth(context) - 38),
              Text(
                "所有标签",
                style:
                    TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Config.lightColor),
              ),
              Provide<TagListModule>(builder: (context, child, mode) {
                return _content(context, mode);
              })
            ],
          ),
        ),
      ));

    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return widgets[index];
      },
      itemCount: widgets.length,
    );
  }

  Widget _content(BuildContext context, TagListModule mode) {
    if (mode.tagList == null || mode.tagList.list.isEmpty) {
      return Center(
          child: Image.asset("assest/images/empty_box.png",
              height: 50, width: 50, color: Config.lightColor));
    } else {
      return Provide<EditPostModule>(builder: (context, child, editMode) {
        ///对tag进行检测
        return buildChildren(editMode.getUnSelectTag(mode.tagList.list), context,
            delete: false,
            click: (tag) => Provide.value<EditPostModule>(context).addTagSelect(tag));
      });
    }
  }
}
