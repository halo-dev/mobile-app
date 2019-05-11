import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:halo/app/config.dart';
import 'package:halo/app/module/site_module.dart';
import 'package:halo/app/provide.dart';
import 'package:halo/app/request_info.dart';
import 'package:halo/event/dialog_event.dart';
import 'package:halo/event/login_change_event.dart';
import 'package:halo/ui/attachments/attachments_manager_model.dart';
import 'package:halo/ui/category/category_manager_module.dart';
import 'package:halo/ui/comment/comment_list_module.dart';
import 'package:halo/ui/login/site_login.dart';
import 'package:halo/ui/main/main_page.dart';
import 'package:halo/ui/post/edit/edit_post_module.dart';
import 'package:halo/ui/post/post_manager_module.dart';
import 'package:halo/ui/tag/tag_manager_module.dart';
import 'package:halo/util/Utils.dart';
import 'package:halo/util/string_util.dart';
import 'package:halo/widget/load_dialog.dart';

void main() {
  runApp(
    ProviderNode(
      providers: Providers()
        ..provide(Provider<SiteModule>.value(SiteModule()))
        ..provide(Provider<TagListModule>.value(TagListModule()))
        ..provide(Provider<CommentListModule>.value(CommentListModule()))
        ..provide(Provider<CategoryListModule>.value(CategoryListModule()))
        ..provide(Provider<EditPostModule>.value(EditPostModule()))
        ..provide(Provider<AttachmentsModule>.value(AttachmentsModule()))
        ..provide(Provider<PostListModule>.value(PostListModule())),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppView();
}

class _MyAppView extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    RxBus().register<DialogChangeEvent>().listen((event) {
      if (event.show && !showLoading) {
        dialogShow(context, "加载中...");
      }

      if (showLoading && !event.show) {
        showLoading = false;
        Navigator.of(context).pop();
      }
    });
    RxBus().register<LoginChangeEvent>().listen((event) {
      Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(builder: (BuildContext context) {
        return MainPage();
      }), (Route<dynamic> route) => false);
    });
  }

  @override
  void dispose() {
    RxBus().destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provide.value<SiteModule>(context).loadData();
    return Provide<SiteModule>(builder: (context, child, site) {
      if (site.site != null && isNotEmpty(site.site.accessToken)) {
        //配置信息
        RequestInfo().update(
            site.site.accessToken, site.site.host, site.site.refreshToken);
      }
      return MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('zh', 'CN'),
          ],
          title: (site.site != null && isNotEmpty(site.site.title))
              ? site.site.title
              : "HaloBlog",
          theme: ThemeData(
              appBarTheme: AppBarTheme(elevation: 2, color: Config.titleColor),
              primarySwatch: Colors.blue,
              textTheme: TextTheme(title: TextStyle(color: Config.fontColor))),
          home: (site.site == null ||
                  isEmpty(site.site.host) ||
                  isEmpty(site.site.accessToken))
              ? SiteLogin()
              : MainPage());
//          home: MainPage()),
    });
  }

  var showLoading = false;

  void dialogShow(BuildContext context, String msg) async {
    Log("showLoading");
    showLoading = true;
    showLoading = await showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog(
            text: msg,
          );
        });
  }
}
