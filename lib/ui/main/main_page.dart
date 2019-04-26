import 'package:flutter/material.dart';
import 'package:halo/app/config.dart';
import 'package:halo/app/module/site.dart';
import 'package:halo/app/module/site_module.dart';
import 'package:halo/app/provide.dart';
import 'package:halo/ui/category/category_manager.dart';
import 'package:halo/ui/comment/comment_list.dart';
import 'package:halo/ui/login/site_login.dart';
import 'package:halo/ui/main/site_view.dart';
import 'package:halo/ui/post/edit/edit_page.dart';
import 'package:halo/ui/post/list/post_list_page.dart';
import 'package:halo/ui/setting/setting_page.dart';
import 'package:halo/ui/tag/tag_manager.dart';
import 'package:halo/util/jump_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPageView();
  }
}

class _MainPageView extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Provide<SiteModule>(
      builder: (context, child, site) => Scaffold(
          backgroundColor: Config.background,
          appBar: AppBar(
            title: Text(site.site.title),
          ),
          floatingActionButton: Container(
            child: FloatingActionButton(
              child: Image.asset(
                "assest/images/push_article.png",
                width: 24,
                height: 24,
                color: Colors.white,
              ),
              tooltip: "发布新文章",
              onPressed: () {
                _openNew(context);
              },
              foregroundColor: Colors.white,
              backgroundColor: Color.fromARGB(255, 0, 135, 190),
              elevation: 5.0,
              highlightElevation: 10.0,
            ),
            margin: EdgeInsets.fromLTRB(0, 0, 30, 50),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//          home: isEmpty(site.site.address) ? SiteLogin() : te.site.title),
//          home: isEmpty(site.site.address) ? SiteLogin() : MainPage()),
          body: buildHome(context, site.site)),
    );
  }

  Widget buildHome(BuildContext context, Site site) {
    List<Widget> widgets = List();

    widgets.add(buildTopView(site));
    widgets.add(createItem(Icons.pie_chart, "统计", null));
    widgets.add(createLabel("发布"));
//    widgets.add(createItem(Icons.assessment, "站点页面"));
    widgets.add(createItem(Icons.library_books, "博客文章", () {
      pushToNewPage(context, PostListPage());
    }));
    widgets.add(createItem(
        Image.asset(
          "assest/images/image_classification.png",
          width: 22,
          height: 22,
          color: Config.fontColor,
        ),
        "分类管理", () {
      pushToNewPage(context, CategoryManagerPage());
    }));
    widgets.add(createItem(
        Image.asset(
          "assest/images/image_tag.png",
          width: 24,
          height: 24,
          color: Config.fontColor,
        ),
        "标签管理", () {
      pushToNewPage(context, TagManagerPage());
    }));
    widgets.add(createItem(Icons.image, "媒体", null));
    widgets.add(createItem(Icons.forum, "评论", () {
      pushToNewPage(context, CommentListPage());
    }));
    widgets.add(createLabel("配置"));
    widgets.add(createItem(Icons.settings, "设置", () {
      pushToNewPage(context, SettingPage());
    }));
    widgets.add(createLabel("外部"));
    widgets.add(createItem(Icons.language, "查看站点", null));
    return ListView.builder(
        itemCount: widgets.length,
        itemBuilder: (BuildContext context, int index) {
          return widgets[index];
        });
  }

  Widget buildTopView(Site site) {
    return Card(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      margin: EdgeInsets.all(5),
      elevation: 2,
      child: new Column(
        children: [
          SiteView(
            site.avatar,
            site.title,
            site.address,
            padding: EdgeInsets.all(10),
          ),
          InkWell(
            child: Container(
                decoration: new BoxDecoration(color: Color.fromARGB(255, 243, 246, 248)),
                child: ListTile(
                  leading: Icon(
                    Icons.keyboard_backspace,
                    color: Config.fontColor,
                  ),
                  title: Text(
                    "切换站点",
                    style: style,
                  ),
                )),
            onTap: () {
              pushToNewPage(context, SiteLogin());
            },
          )
        ],
      ),
    );
  }

  Widget createItem(icon, title, Function callBack) {
    return ListTile(
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
    );
  }

  TextStyle style = TextStyle(fontSize: 16, color: Color.fromARGB(255, 102, 142, 170));

  Widget createLabel(txt) {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: Text(txt, style: style),
    );
  }

  _openNew(BuildContext context) {
    pushToNewPage(context, EditPostPage());
  }
}
