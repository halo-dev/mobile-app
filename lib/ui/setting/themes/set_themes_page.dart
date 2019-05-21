import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:halo/app/base/base_widget.dart';
import 'package:halo/app/config.dart' as cf;
import 'package:halo/app/provide.dart';
import 'package:halo/app/request_info.dart';
import 'package:halo/ui/setting/themes/set_themes_module.dart';
import 'package:halo/ui/setting/themes/theme_list_item.dart';
import 'package:halo/util/Utils.dart';
import 'package:halo/widget/loading_dialog.dart';
import 'package:halo/widget/refresh_list.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SetThemePage extends BaseState with PullRefreshMixIn {
  RefreshController controller;
  int type;

  @override
  void initState() {
    super.initState();
    controller = RefreshController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cf.Config.background,
      appBar: AppBar(
        title: Text("主题管理"),
//        actions: <Widget>[
//          IconButton(
//              icon: Image.asset(
//                "assest/images/theme_set.png",
//                height: 20,
//                width: 20,
//                color: Colors.white,
//              ),
//              onPressed: _setTheme)
//        ],
      ),
      body: Provide<SetThemeModule>(builder: (context, child, mode) {
        return _buildList(context, mode);
      }),
    );
  }

  @override
  void onFirstInit() {
    refresh();
  }

  void refresh() {
    Provide.value<SetThemeModule>(context).getThemeList();
  }

  Widget _buildList(BuildContext context, SetThemeModule mode) {
    finishRefresh(controller);
    IndexedWidgetBuilder builder;
    if (mode.themesList == null || mode.themesList.list.isEmpty) {
      builder = (BuildContext context, int index) {
        return loadWithStatus(mode.status);
      };
    } else {
      builder = (BuildContext context, int index) {
        return ThemesListItem(mode.themesList.list[index]);
      };
    }
    return buildRefresh(builderList(mode?.themesList?.list?.length ?? 1, builder), (up) {
      refresh();
    }, controller);
  }

  void _setTheme() {
    pushToNewPage(
        context,
        WebviewScaffold(
          url: "${RequestInfo().HOST}/admin/index.html#/interface/themes",
          appBar: new AppBar(
            title: const Text('主题设置'),
          ),
          withZoom: true,
          withLocalStorage: true,
          hidden: true,
          enableAppScheme: true,
          headers: RequestInfo().params,
        ));
  }
}
