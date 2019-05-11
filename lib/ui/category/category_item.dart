import 'package:flutter/material.dart';
import 'package:halo/app/config.dart';
import 'package:halo/app/provide.dart';
import 'package:halo/module/category_list.dart';
import 'package:halo/ui/category/category_manager_module.dart';
import 'package:halo/ui/category/create_category.dart';
import 'package:halo/ui/post/edit/edit_post_module.dart';
import 'package:halo/ui/post/list/post_list_page.dart';
import 'package:halo/util/Utils.dart';

Widget createCategoryItem(item, BuildContext context, {bool select = true}) {
  return findChildItem(item, 15, context, select);
}

Widget findChildItem(
    Category item, int padding, BuildContext context, bool select) {
  if (item.children != null && item.children.isNotEmpty) {
    List<Widget> list = new List();
    list.add(select
        ? createItem(item, padding, context)
        : buildSelectItem(item, padding, context));
    item.children.forEach((data) {
      list.add(findChildItem(data, padding + 15, context, select));
    });
    return Column(children: list);
  } else
    return select
        ? createItem(item, padding, context)
        : buildSelectItem(item, padding, context);
}

Widget createItem(Category item, int padding, BuildContext context) {
  return InkWell(
    child: Column(
      children: [
        Container(
          color: Colors.white,
          margin: EdgeInsets.all(0),
          padding: EdgeInsets.fromLTRB(padding.toDouble(), 10, 15, 10),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                      child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.name,
                    softWrap: false,
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        height: 1.0,
                        fontSize: 16,
                        color: Config.fontColor),
                  ),
                  Text(
                    item.description,
                    style: TextStyle(
                        height: 1.0,
                        fontSize: 14,
                        color: Color.fromARGB(255, 102, 142, 170)),
                  ),
                ],
              ))),
              PopupMenuButton(
//              icon: Icon(Icons.home),
                child: IconButton(icon: Icon(Icons.more_vert), onPressed: null),
                tooltip: "更多操作",
                initialValue: "hot",
                padding: EdgeInsets.all(0.0),
                itemBuilder: (BuildContext context) {
                  return <PopupMenuItem<String>>[
                    PopupMenuItem<String>(
                      child: Text("修改"),
                      value: "modify",
                    ),
                    PopupMenuItem<String>(
                      child: Text("移除"),
                      value: "remove",
                    ),
                  ];
                },
                onSelected: (String action) {
                  switch (action) {
                    //修改
                    case "modify":
                      pushToNewPage(context, CreateCategoryPage(item, true));
                      break;
                    case "remove":
                      Provide.value<CategoryListModule>(context).delete(item);
                      break;
                  }
                },
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
        )
      ],
    ),
    onTap: () {
      pushToNewPage(context, PostListPage(category: item));
    },
  );
}

Widget buildSelectItem(Category item, int padding, BuildContext context) {
  ///判断是否是选中的item
  return InkWell(
    onTap: () {
      ///判断是否进行添加或者移除
      Provide.value<EditPostModule>(context).addOrRemoveCategory(item);
    },
    child: Column(children: <Widget>[
      Container(
        height: 45,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(padding.toDouble(), 0, 15, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: Text(
              item.name,
              softWrap: false,
              style: TextStyle(fontSize: 15, color: Config.fontColor),
            )),
            Offstage(
              offstage:
                  !Provide.value<EditPostModule>(context).hasCategory(item),
              child: Icon(Icons.done, size: 24, color: Config.fontColor),
            ),
          ],
        ),
      ),
      Divider(height: 1, color: Colors.transparent)
    ]),
  );
}
