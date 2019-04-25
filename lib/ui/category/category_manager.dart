import 'package:flutter/material.dart';
import 'package:halo/app/config.dart' as cf;
import 'package:halo/app/provide.dart';
import 'package:halo/ui/category/category_item.dart';
import 'package:halo/ui/category/category_manager_module.dart';
import 'package:halo/ui/category/create_category.dart';
import 'package:halo/util/Utils.dart';
import 'package:halo/widget/loading_dialog.dart';
import 'package:halo/widget/refresh_list.dart';
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
    Provide.value<CategoryListModule>(context).updateList();
    return Scaffold(
      backgroundColor: cf.Config.background,
      appBar: AppBar(
        elevation: 0,
        title: Text("分类管理"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () {
              _addNew(context);
            },
          )
        ],
      ),
      body: Provide<CategoryListModule>(builder: (context, child, mode) {
        return _buildList(context, mode);
      }),
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
        return createCategoryItem(mode.cateList.list[index], context);
      };
    }

    return buildRefresh(
        builderList(
            (mode.cateList == null || mode.cateList.list.isEmpty) ? 1 : mode.cateList.list.length,
            builder), (up) {
      Provide.value<CategoryListModule>(context).updateList();
    }, controller);
  }

  void _addNew(BuildContext context) {
    pushToNewPage(context, CreateCategoryPage.create());
  }
}
