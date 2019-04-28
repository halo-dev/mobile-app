import 'package:flutter/material.dart';
import 'package:halo/app/provide.dart';
import 'package:halo/module/tag_list.dart';
import 'package:halo/ui/tag/tag_manager_module.dart';
import 'package:halo/util/Utils.dart';

Widget buildChildren(List<Tag> children, BuildContext context,
    {bool delete = true, Function onDelete, Function click}) {
  List<Widget> tiles = [];
  Widget content;
  for (var item in children) {
    tiles.add(
      click == null
          ? _buildChip(item, delete, onDelete, context)
          : InkWell(
              child: _buildChip(item, delete, onDelete, context),
              onTap: () {
                click(item);
              },
            ),
    );
  }
  content = Padding(
    padding: EdgeInsets.all(10),
    child: Wrap(spacing: 12, runSpacing: 12, alignment: WrapAlignment.start, children: tiles),
  );
  return content;
}

Chip _buildChip(Tag item, bool delete, Function onDelete, BuildContext context) {
  return Chip(
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    backgroundColor: Utils.nameToColor(item.name),
    label: new Text(item.name),
    deleteIcon: delete
        ? Icon(
            Icons.close,
            color: Colors.black,
            size: 20,
          )
        : null,
    onDeleted: delete
        ? onDelete == null
            ? () {
                Provide.value<TagListModule>(context).delete(item);
              }
            : null
        : null,
  );
}
