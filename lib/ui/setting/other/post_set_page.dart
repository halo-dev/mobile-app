import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:halo/app/provide.dart';
import 'package:halo/module/options.dart';
import 'package:halo/ui/setting/setting_module.dart';
import 'package:halo/ui/setting/setting_page_base.dart';

class PostSetPage extends SettingPageBase {
  final TextEditingController _indexMaxController = new TextEditingController();
  final TextEditingController _ResMaxController = new TextEditingController();
  final TextEditingController _PostController = new TextEditingController();

  @override
  void onFirstInit() {}

  @override
  List<Widget> buildWidgetList(Options options) {
    List<Widget> list = new List();
    _indexMaxController.text = options.postIndexPageSize.toString();
    _ResMaxController.text = options.rssPageSize.toString();
    _PostController.text = options.postSummaryLength.toString();

    list.add(buildItem("首页显示条数：", _indexMaxController));
    list.add(buildItem("RSS 显示条数：", _ResMaxController));
    list.add(buildItem("文章摘要字数：", _PostController));
    return list;
  }

  @override
  void onSaved() {
    Provide.value<SettingModule>(context).options.postIndexPageSize =
        int.parse(_indexMaxController.text);
    Provide.value<SettingModule>(context).options.rssPageSize = int.parse(_ResMaxController.text);
    Provide.value<SettingModule>(context).options.postSummaryLength =
        int.parse(_PostController.text);
    saveData();
  }

  @override
  String getTitle() {
    return "文章设置";
  }
}
