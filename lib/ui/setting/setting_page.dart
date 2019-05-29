import 'package:flutter/material.dart';
import 'package:halo/app/base/base_widget.dart';
import 'package:halo/app/config.dart';
import 'package:halo/app/provide.dart';
import 'package:halo/ui/setting/general/general_set_page.dart';
import 'package:halo/ui/setting/seo/seo_set_page.dart';
import 'package:halo/ui/setting/setting_module.dart';
import 'package:halo/util/Utils.dart';

class SettingPage extends BaseState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Config.background,
        appBar: AppBar(
          title: Text("博客设置"),
        ),
//          home: isEmpty(site.site.address) ? SiteLogin() : te.site.title),
//          home: isEmpty(sitebuildSettings) ? SiteLogin() : MainPage()),
        body: buildSetting(context));
  }

  buildSetting(BuildContext context) {
    List<Widget> widgets = List();
    widgets.add(createItem(Icons.build, "常规设置", () {
      pushToNewPageWithWidget(context, GeneralSetPage());
    }));
    widgets.add(createItem(Icons.language, "SEO 设置", () {
      pushToNewPageWithWidget(context, SeoSetPage());
    }));
    widgets.add(createItem(Icons.library_books, "文章设置", () {
//      pushToNewPageWithWidget(context, SettingPage());
    }));
    widgets.add(createItem(Icons.forum, "评论设置", () {
//      pushToNewPageWithWidget(context, SettingPage());
    }));
    widgets.add(createItem(Icons.attachment, "附件设置", () {
//      pushToNewPageWithWidget(context, SettingPage());
    }));
    widgets.add(createItem(Icons.mail_outline, "SMTP 设置", () {
//      pushToNewPageWithWidget(context, SettingPage());
    }));
    widgets.add(createItem(Icons.format_list_bulleted, "其他设置", () {
//      pushToNewPageWithWidget(context, SettingPage());
    }));
    return ListView.builder(
        itemCount: widgets.length,
        itemBuilder: (BuildContext context, int index) {
          return widgets[index];
        });
  }

  Widget createItem(icon, title, Function callBack) {
    return Material(
      shape: new BorderDirectional(
          //BorderSide默认是BorderStyle.solid
          bottom: new BorderSide(
        color: Color(0x1d000000),
        width: 0.5,
      )),
      color: Colors.white,
      child: ListTile(
        onTap: callBack,
        leading: icon is Widget
            ? icon
            : Icon(
                icon,
                size: 24,
                color: Config.fontColor,
              ),
        title: Text(
          title,
          style: TextStyle(fontSize: 16, color: Config.fontColor),
        ),
      ),
    );
  }

  @override
  void onFirstInit() {
    Provide.value<SettingModule>(context).getSiteTitle();
  }
}
