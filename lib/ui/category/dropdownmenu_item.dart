import 'package:flutter/material.dart';
import 'package:halo/app/config.dart';
import 'package:halo/module/category_list.dart';

List<DropdownMenuItem<Category>> createDropdownMenuItem(item, int currentID, BuildContext context) {
  return findChildItem(item, currentID, 15, context);
}

List<DropdownMenuItem<Category>> findChildItem(
    Category item, int currentID, int padding, BuildContext context) {
  List<DropdownMenuItem<Category>> list = new List<DropdownMenuItem<Category>>();
  if (item.children != null && item.children.isNotEmpty) {
    list.add(createItem(item, padding, context));
    for (var value in item.children) {
      if (value.id == currentID) {
        continue;
      }
      list.addAll(findChildItem(value, currentID, padding + 15, context));
    }
  } else
    list.add(createItem(item, padding, context));
  return list;
}

DropdownMenuItem<Category> createItem(Category item, int padding, BuildContext context) {
  return DropdownMenuItem(
      value: item,
      child: Row(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: padding.toDouble()),
              width: MediaQuery.of(context).size.width - 55,
              child: Text(
                item.name,
                softWrap: false,
                style: TextStyle(fontSize: 15, color: Config.fontColor),
              )),
          Offstage(
            offstage: true,
            child: Icon(Icons.done, size: 24, color: Config.fontColor),
          ),
        ],
      ));
}
