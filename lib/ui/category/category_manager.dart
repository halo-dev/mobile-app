import 'package:flutter/material.dart';
import 'package:halo/app/config.dart' as cf;
import 'package:halo/app/provide.dart';
import 'package:halo/ui/category/category_item.dart';
import 'package:halo/ui/category/category_manager_module.dart';
import 'package:halo/widget/loading_dialog.dart';
import 'package:halo/widget/refresh_list.dart';
import 'package:halo/widget/textfield_alertdialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoryManagerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CategoryManagerPageView();
  }
}

class _CategoryManagerPageView extends State<CategoryManagerPage> with PullRefreshMixIn {
  RefreshController controller;

  @override
  void initState() {
    super.initState();
    controller = RefreshController();
  }

  @override
  Widget build(BuildContext context) {
    Provide.value<CategoryListModule>(context).updateList(context);
    return Scaffold(
      backgroundColor: cf.Config.background,
      appBar: AppBar(
        elevation: 0,
        title: Text("分类管理"),
      ),
      body: Provide<CategoryListModule>(builder: (context, child, mode) {
        return _buildList(context, mode);
      }),
      floatingActionButton: Container(
        child: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 25,
          ),
          tooltip: "添加分类",
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
    CategoryListModule mode,
  ) {
    finishRefresh(controller);
    IndexedWidgetBuilder builder;
    if (mode.cateList == null || mode.cateList.list.isEmpty) {
      builder = (BuildContext context, int index) {
        return loadWithStatus(mode.status);
      };
    } else {
      builder = (BuildContext context, int index) {
        return createCategoryItem(mode.cateList.list[index]);
      };
    }

    return buildRefresh(
        builderList(
            (mode.cateList == null || mode.cateList.list.isEmpty) ? 1 : mode.cateList.list.length,
            builder), (up) {
      Provide.value<CategoryListModule>(context).updateList(context);
    }, controller);
  }

  void _addNew(BuildContext context) {
    TextFieldDialog(context, "创建新分类", (name, slug) {
//      Provide.value<CategoryListModule>(context).create(name, slug);
    });
  }
}
