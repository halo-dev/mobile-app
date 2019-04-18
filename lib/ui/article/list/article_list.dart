import 'package:flutter/material.dart';
import 'package:halo/app/config.dart' as cf;
import 'package:halo/app/provide.dart';
import 'package:halo/module/article.dart';
import 'package:halo/ui/article/edit/edit_page.dart';
import 'package:halo/ui/article/list/article_list_module.dart';
import 'package:halo/ui/article/list/list_item.dart';
import 'package:halo/util/jump_page.dart';
import 'package:halo/widget/refresh_list.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ArticleListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ArticleListPageView();
  }
}

class _ArticleListPageView extends State<ArticleListPage> with PullRefreshMixIn {
  RefreshController controller;

  @override
  void initState() {
    super.initState();
    controller = RefreshController();
  }

  @override
  Widget build(BuildContext context) {
    Provide.value<ArticleListModule>(context).refresh(true);
    return Scaffold(
      backgroundColor: cf.Config.background,
      appBar: AppBar(
        title: Text("博客文章"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Image.asset(
          "assest/images/push_article.png",
          width: 24,
          height: 24,
          color: Colors.white,
        ),
        tooltip: "发布新文章",
        onPressed: () {
          pushToNewPage(context, EditPage());
        },
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 0, 135, 190),
        elevation: 5.0,
        highlightElevation: 10.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Provide<ArticleListModule>(builder: (context, child, mode) {
        return _buildList(context, mode.articleList);
      }),
    );
  }

  Widget _buildList(
    BuildContext context,
    List<Content> articleList,
  ) {
    if (controller.headerStatus == RefreshStatus.refreshing ||
        controller.footerStatus == RefreshStatus.refreshing) {
      controller.sendBack(
          controller.headerStatus == RefreshStatus.refreshing, RefreshStatus.completed);
    }
    IndexedWidgetBuilder builder;
    if (articleList.isEmpty) {
      builder = (BuildContext context, int index) {
        return CircularProgressIndicator();
      };
    } else {
      builder = (BuildContext context, int index) {
        return ListItemPage(articleList[index]);
      };
    }
    return buildRefresh(builderList(articleList.length, builder), (up) {
      Provide.value<ArticleListModule>(context).refresh(up);
    }, controller);
  }
}
