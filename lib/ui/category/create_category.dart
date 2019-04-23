import 'package:flutter/material.dart';
import 'package:halo/app/config.dart' as cf;
import 'package:halo/app/provide.dart';
import 'package:halo/ui/category/category_manager_module.dart';
import 'package:halo/widget/refresh_list.dart';
import 'package:halo/widget/textfield_alertdialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CreateCategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateCategoryPageView();
  }
}

class _CreateCategoryPageView extends State<CreateCategoryPage> with PullRefreshMixIn {
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
        title: Text("分类"),
      ),
      body: _buildCreate(),
    );
  }

  void _addNew(BuildContext context) {
    TextFieldDialog(context, "创建新分类", (name, slug) {
//      Provide.value<CategoryListModule>(context).create(name, slug);
    });
  }

  _buildCreate() {
//    return
  }
}
