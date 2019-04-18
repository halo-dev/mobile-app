import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

typedef Future OnRefresh(bool up);

class PullRefreshMixIn {
  factory PullRefreshMixIn._() => null;

  Widget buildListView(List<Widget> widgets) => ListView.builder(
      itemCount: widgets.length,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      itemBuilder: (BuildContext context, int position) {
        return widgets[position];
      });

  Widget builderList(int size, IndexedWidgetBuilder builder) => ListView.builder(
      itemCount: size, padding: EdgeInsets.fromLTRB(0, 0, 0, 0), itemBuilder: builder);

  Widget buildRefresh(Widget view, OnRefresh refresh, RefreshController controller,
      {bool enableLoadMore: false, bool enableRefresh: true, bool autoLoad: false}) {
    return SmartRefresher(
      enablePullUp: enableLoadMore,
      controller: controller,
      headerBuilder: _headerCreate,
      footerBuilder: _headerCreate,
      enablePullDown: enableRefresh,
      enableOverScroll: true,
      footerConfig: LoadConfig(autoLoad: autoLoad),
      headerConfig: RefreshConfig(completeDuration: 200),
      onRefresh: refresh,
      child: view,
    );
  }

  ClassicIndicator _headerCreate(BuildContext context, RefreshStatus mode) {
    return ClassicIndicator(
        releaseText: "下拉刷新",
        idleText: "释放刷新",
        refreshingText: "正在刷新...",
        completeText: "刷新结束",
        failedText: "刷新失败",
        noDataText: "更新于 %T",
        mode: mode);
  }
}
