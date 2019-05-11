import 'package:flutter/material.dart';
import 'package:halo/app/config.dart' as cf;
import 'package:halo/app/provide.dart';
import 'package:halo/module/comment.dart';
import 'package:halo/ui/comment/comment_list_item.dart';
import 'package:halo/ui/comment/comment_list_module.dart';
import 'package:halo/widget/refresh_list.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommentListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CommentListPageView();
}

class _CommentListPageView extends State<CommentListPage>
    with PullRefreshMixIn {
  RefreshController controller;

  @override
  void initState() {
    super.initState();
    controller = RefreshController();
  }

  @override
  Widget build(BuildContext context) {
    Provide.value<CommentListModule>(context).refresh(true);
    return Scaffold(
      backgroundColor: cf.Config.background,
      appBar: AppBar(
        elevation: 0,
        title: Text("评论"),
      ),
      body: Provide<CommentListModule>(builder: (context, child, mode) {
        return _buildList(context, mode.commentList);
      }),
    );
  }

  Widget _buildList(
    BuildContext context,
    List<Comment> commentList,
  ) {
    if (controller.headerStatus == RefreshStatus.refreshing ||
        controller.footerStatus == RefreshStatus.refreshing) {
      controller.sendBack(controller.headerStatus == RefreshStatus.refreshing,
          RefreshStatus.completed);
    }
    IndexedWidgetBuilder builder;
    if (commentList.isEmpty) {
      builder = (BuildContext context, int index) {
        return CircularProgressIndicator();
      };
    } else {
      builder = (BuildContext context, int index) {
        return CommentListItemPage(commentList[index]);
      };
    }
    return buildRefresh(builderList(commentList.length, builder), (up) {
      Provide.value<CommentListModule>(context).refresh(up);
    }, controller);
  }
}
