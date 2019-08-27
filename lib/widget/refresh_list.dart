import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PullRefreshMixIn {
  factory PullRefreshMixIn._() => null;

  Widget buildListView(List<Widget> widgets) => ListView.builder(
      itemCount: widgets.length,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      itemBuilder: (BuildContext context, int position) {
        return widgets[position];
      });

  Widget builderList(int size, IndexedWidgetBuilder builder) =>
      ListView.builder(
          itemCount: size,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          itemBuilder: builder);

  Widget buildRefresh(Widget view, refresh, RefreshController controller,
      {bool enableLoadMore: false,
      bool enableRefresh: true,
      bool autoLoad: false}) {
    return SmartRefresher(
      enablePullUp: enableLoadMore,
      controller: controller,
      header: ClassicHeader(
        releaseText: "下拉刷新",
        idleText: "释放刷新",
        refreshingText: "正在刷新...",
        completeText: "刷新结束",
        failedText: "刷新失败",
      ),
      footer: ClassicFooter(
        noDataText: "更新于 %T",
      ),
      enablePullDown: enableRefresh,
      onRefresh: refresh,
      child: view,
    );
  }

  void finishRefresh(RefreshController controller) {
    if (controller.headerStatus == RefreshStatus.refreshing ||
        controller.footerStatus == RefreshStatus.refreshing) {
      controller.refreshCompleted();
    }
  }
}
