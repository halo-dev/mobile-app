import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:halo/app/config.dart';
import 'package:halo/app/module/site_module.dart';
import 'package:halo/app/provide.dart';
import 'package:halo/app/request_info.dart';
import 'package:halo/ui/category/category_manager_module.dart';
import 'package:halo/ui/comment/comment_list_module.dart';
import 'package:halo/ui/login/site_login.dart';
import 'package:halo/ui/main/main_page.dart';
import 'package:halo/ui/post/post_manager_module.dart';
import 'package:halo/ui/tag/tag_manager_module.dart';
import 'package:halo/util/string_util.dart';

void main() {
  runApp(
    ProviderNode(
      providers: Providers()
        ..provide(Provider<SiteModule>.value(SiteModule()))
        ..provide(Provider<TagListModule>.value(TagListModule()))
        ..provide(Provider<CommentListModule>.value(CommentListModule()))
        ..provide(Provider<CategoryListModule>.value(CategoryListModule()))
        ..provide(Provider<PostListModule>.value(PostListModule())),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Provide.value<SiteModule>(context).loadData();
    return Provide<SiteModule>(builder: (context, child, site) {
      if (site.site != null && isNotEmpty(site.site.title)) {
        //配置信息
        RequestInfo().HOST = site.site.address;
      }
      return MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('zh', 'CN'),
          ],
          title: (site.site != null && isNotEmpty(site.site.title)) ? site.site.title : "HaloBlog",
          theme: ThemeData(
              appBarTheme: AppBarTheme(elevation: 2),
              primarySwatch: Colors.blue,
              textTheme: TextTheme(title: TextStyle(color: Config.fontColor))),
          home: (site.site == null || isEmpty(site.site.address)) ? SiteLogin() : MainPage());
//          home: MainPage()),
    });
  }
}
