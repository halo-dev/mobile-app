import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:halo/app/base/base_widget.dart';
import 'package:halo/app/provide.dart';
import 'package:halo/module/options.dart';
import 'package:halo/ui/setting/setting_module.dart';
import 'package:halo/ui/setting/setting_view.dart';

class SeoSetPage extends BaseState {
  final TextEditingController _KeyController = new TextEditingController();
  final TextEditingController _blogController = new TextEditingController();
  final TextEditingController _bottomController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Provide<SettingModule>(builder: (context, child, mode) {
      return getPageView(context, _buildListItem(mode.options), () {});
    });
  }

  @override
  void onFirstInit() {}

  List<Widget> _buildListItem(Options options) {
    List<Widget> list = new List();
    _KeyController.text = options.seo_keywords;
    _blogController.text = options.blog_url;
    _bottomController.text = options.blog_footer_info;
    list.add(buildItem("关键词：", _KeyController));
    list.add(buildItem("博客地址：", _blogController));
    list.add(buildItem("页脚信息：", _bottomController, minLine: 5));
    return list;
  }
}
