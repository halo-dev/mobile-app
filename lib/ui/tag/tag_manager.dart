import 'package:flutter/material.dart';
import 'package:halo/app/base/base_widget.dart';
import 'package:halo/app/config.dart' as cf;
import 'package:halo/app/provide.dart';
import 'package:halo/module/tag_list.dart';
import 'package:halo/ui/tag/tag_manager_module.dart';
import 'package:halo/util/Utils.dart';
import 'package:halo/widget/loading_dialog.dart';
import 'package:halo/widget/refresh_list.dart';
import 'package:halo/widget/textfield_alertdialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TagManagerPage extends BaseState with PullRefreshMixIn {
  RefreshController controller;

  @override
  void initState() {
    super.initState();
    controller = RefreshController();
//    Provide.value<TagListModule>(context).updatelist();
//    TagListModule().updateList()
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cf.Config.background,
      appBar: AppBar(
        title: Text("标签管理"),
      ),
      body: Provide<TagListModule>(builder: (context, child, mode) {
        return _buildList(context, mode);
      }),
      floatingActionButton: Container(
        child: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 25,
          ),
          tooltip: "添加标签",
          onPressed: () {
            _addNew(context);
          },
          foregroundColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 0, 135, 190),
          elevation: 5.0,
          highlightElevation: 10.0,
        ),
        margin: EdgeInsets.fromLTRB(0, 0, 30, 50),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildList(
    BuildContext context,
    TagListModule mode,
  ) {
    if (controller.headerStatus == RefreshStatus.refreshing ||
        controller.footerStatus == RefreshStatus.refreshing) {
      controller.refreshCompleted();
    }
    IndexedWidgetBuilder builder;
    if (mode.tagList == null || mode.tagList.list.isEmpty) {
      builder = (BuildContext context, int index) {
        return loadWithStatus(mode.status);
      };
    } else {
      builder = (BuildContext context, int index) {
        return buildChildren(mode.tagList.list, context);
      };
    }
    return buildRefresh(builderList(1, builder), (up) {
      Provide.value<TagListModule>(context).updateList();
    }, controller);
  }

  Widget buildChildren(List<Tag> children, BuildContext context) {
    List<Widget> tiles = [];
    Widget content;
    for (var item in children) {
      tiles.add(
        InkWell(
          onTap: () {
            _update(context, item.id, item.name, item.slugName);
          },
          child: new Chip(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor: Utils.nameToColor(item.name),
            label: new Text(item.name),
            deleteIcon: Icon(
              Icons.close,
              color: Colors.black,
              size: 20,
            ),
            onDeleted: () {
              Provide.value<TagListModule>(context).delete(item);
            },
          ),
        ),
      );
    }
    content = Padding(
      padding: EdgeInsets.all(10),
      child: Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.start,
          children: tiles),
    );
    return content;
  }

  void _addNew(BuildContext context) {
    TextFieldDialog(context, "创建新标签", (name, slug) {
      Provide.value<TagListModule>(context).create(name, slug);
    });
  }

  void _update(BuildContext context, int id, String tagName, String slugName) {
    TextFieldDialog.update(context, "更新标签", tagName, slugName, (name, slug) {
      var tag = Tag.fromParams(id: id, name: name, slugName: slug);
      Provide.value<TagListModule>(context).update(tag);
    });
  }

  @override
  void onFirstInit() {
    Provide.value<TagListModule>(context).updateList();
  }
}
