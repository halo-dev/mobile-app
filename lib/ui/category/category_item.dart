import 'package:flutter/material.dart';
import 'package:halo/app/config.dart';
import 'package:halo/module/category_list.dart';
import 'package:halo/ui/article/edit/edit_page.dart';
import 'package:halo/util/Utils.dart';

Widget createCategoryItem(item, BuildContext context) {
  return findChildItem(item, 15, context);
}

Widget findChildItem(Category item, int padding, BuildContext context) {
  if (item.children != null && item.children.isNotEmpty) {
    List<Widget> list = new List();
    list.add(createItem(item, padding, context));

    item.children.forEach((data) {
      list.add(findChildItem(data, padding + 15, context));
    });
    return Column(children: list);
  } else
    return createItem(item, padding, context);
}

Widget createItem(Category item, int padding, BuildContext context) {
  return new Column(
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
                      height: 1.0, fontSize: 14, color: Color.fromARGB(255, 102, 142, 170)),
                ),
              ],
            ))),
            InkWell(
              child: Image.asset(
                "assest/images/image_modify.png",
                width: 20,
                height: 20,
                color: Config.fontColor,
              ),
              onTap: () {
                //change
                pushToNewPage(context, EditPage());
              },
            ),
          ],
        ),
      ),
      Divider(
        height: 1,
      )
    ],
  );
}
