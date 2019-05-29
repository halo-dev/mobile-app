import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:halo/app/provide.dart';
import 'package:halo/module/options.dart';
import 'package:halo/ui/setting/setting_module.dart';
import 'package:halo/ui/setting/setting_page_base.dart';

class SeoSetPage extends SettingPageBase {
  final TextEditingController _KeyController = new TextEditingController();
  final TextEditingController _blogController = new TextEditingController();
  final TextEditingController _baidu_tokenController = new TextEditingController();
  final TextEditingController _baiduController = new TextEditingController();
  final TextEditingController _googleController = new TextEditingController();
  final TextEditingController _bingController = new TextEditingController();
  final TextEditingController _360Controller = new TextEditingController();

  @override
  void onFirstInit() {}

  @override
  List<Widget> buildWidgetList(Options options) {
    List<Widget> list = new List();
    _KeyController.text = options.seoKeywords;
    _blogController.text = options.blogUrl;
    _baidu_tokenController.text = options.seoBaiduToken;
    _baiduController.text = options.seoVerificationBaidu;
    _googleController.text = options.seoVerificationGoogle;
    _bingController.text = options.seoVerificationBing;
    _360Controller.text = options.seoVerificationQihu;

    list.add(buildItem("关键词：", _KeyController));
    list.add(buildItem("博客描述：", _blogController));
    list.add(buildItem("百度推送 Token：", _baidu_tokenController));
    list.add(buildItem("百度站点验证：", _baiduController));
    list.add(buildItem("Google 站点验证：", _googleController));
    list.add(buildItem("Bing 站点验证：", _bingController));
    list.add(buildItem("360 站点验证：", _360Controller));
    return list;
  }

  @override
  void onSaved() {
    Provide.value<SettingModule>(context).options.seoKeywords = _KeyController.text;
    Provide.value<SettingModule>(context).options.blogUrl = _blogController.text;
    Provide.value<SettingModule>(context).options.seoBaiduToken = _baidu_tokenController.text;
    Provide.value<SettingModule>(context).options.seoVerificationBaidu = _baiduController.text;
    Provide.value<SettingModule>(context).options.seoVerificationGoogle = _googleController.text;
    Provide.value<SettingModule>(context).options.seoVerificationBing = _bingController.text;
    Provide.value<SettingModule>(context).options.seoVerificationQihu = _360Controller.text;
    saveData();
  }
}
