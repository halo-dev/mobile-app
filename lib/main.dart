import 'package:flutter/material.dart';
import 'package:halo/app/config.dart';
import 'package:halo/app/module/site_module.dart';
import 'package:halo/app/provide.dart';
import 'package:halo/ui/article/list/article_list_module.dart';
import 'package:halo/ui/comment/comment_list_module.dart';
import 'package:halo/ui/login/site_login.dart';
import 'package:halo/ui/main/main_page.dart';
import 'package:halo/util/string_util.dart';

void main() {
  runApp(
    ProviderNode(
      providers: Providers()
        ..provide(Provider<SiteModule>.value(SiteModule()))
        ..provide(Provider<CommentListModule>.value(CommentListModule()))
        ..provide(Provider<ArticleListModule>.value(ArticleListModule())),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Provide.value<SiteModule>(context).loadData();
    return Provide<SiteModule>(
      builder: (context, child, site) => MaterialApp(
          title: (site.site != null && isNotEmpty(site.site.title)) ? site.site.title : "HaloBlog",
          theme: ThemeData(
              appBarTheme: AppBarTheme(elevation: 2),
              primarySwatch: Colors.blue,
              textTheme: TextTheme(title: TextStyle(color: Config.fontColor))),
          home: (site.site == null || isEmpty(site.site.address)) ? SiteLogin() : MainPage()),
//          home: MainPage()),
    );
  }
}
