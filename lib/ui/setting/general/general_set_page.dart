import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:halo/app/config.dart';
import 'package:halo/app/provide.dart';
import 'package:halo/module/options.dart';
import 'package:halo/ui/attachments/attachments_list_page.dart';
import 'package:halo/ui/setting/setting_module.dart';
import 'package:halo/ui/setting/setting_page_base.dart';
import 'package:halo/util/Utils.dart';
import 'package:halo/widget/avatar_text_set.dart';

class GeneralSetPage extends SettingPageBase {
  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _blogController = new TextEditingController();
  final TextEditingController _bottomController = new TextEditingController();

  @override
  void onFirstInit() {}

  @override
  List<Widget> buildWidgetList(Options options) {
    List<Widget> list = new List();
    _titleController.text = options.blogTitle;
    _blogController.text = options.blogUrl;
    _bottomController.text = options.blogFooterInfo;
    list.add(buildItem("博客标题：", _titleController));
    list.add(buildItem("博客地址：", _blogController));
    list.add(buildItem("页脚信息：", _bottomController, minLine: 5));

    list.add(buildAvatarTextItem("Logo：", options.blogLogo, () async {
      String path = await pushToNewPageWithWidget(context, AttachmentsListPage.byType(avatar));
      if (isNotEmpty(path)) {
        options.blogLogo = path;
      }
    }, avatar: true));
    list.add(Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Container(
          height: 1,
          color: Config.fontColor,
        )));
    list.add(buildAvatarTextItem("Favicon：", options.blogFavicon, () async {
      String path = await pushToNewPageWithWidget(context, AttachmentsListPage.byType(avatar));
      if (isNotEmpty(path)) {
        options.blogFavicon = path;
      }
    }, avatar: true));
    return list;
  }

  @override
  void onSaved() {
    if (isEmpty(_titleController.text)) {
      ToastUtil.showToast("请完善博客标题");
      return;
    }
    if (isEmpty(_blogController.text)) {
      ToastUtil.showToast("请完善博客地址");
      return;
    }
    Provide.value<SettingModule>(context).options.blogTitle = _titleController.text;
    Provide.value<SettingModule>(context).options.blogUrl = _blogController.text;
    saveData();
  }

  @override
  String getTitle() {
    return "常规设置";
  }
}
