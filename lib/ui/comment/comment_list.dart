import 'package:flutter/material.dart';
import 'package:halo/app/base/base_widget.dart';
import 'package:halo/app/config.dart' as cf;
import 'package:halo/app/provide.dart';
import 'package:halo/ui/comment/comment_list_item.dart';
import 'package:halo/ui/comment/comment_list_module.dart';
import 'package:halo/widget/loading_dialog.dart';
import 'package:halo/widget/refresh_list.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//class CommentListPage extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() => _CommentListPageView();
//}

class CommentListPage extends BaseState with PullRefreshMixIn {
  RefreshController controller;

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
        elevation: 0,
        title: Text("评论"),
      ),
      body: Provide<CommentListModule>(builder: (context, child, mode) {
        return _buildList(context, mode);
      }),
    );
  }

  Widget _buildList(
    BuildContext context,
    CommentListModule mode,
  ) {
    finishRefresh(controller);
    IndexedWidgetBuilder builder;
    if (mode.comment == null || mode.comment.isEmpty) {
      builder = (BuildContext context, int index) {
        return loadWithStatus(mode.status);
      };
    } else {
      builder = (BuildContext context, int index) {
        return CommentListItemPage(mode.comment.content[index]);
      };
    }
    return buildRefresh(builderList(mode?.comment?.content?.length ?? 1, builder), (up) {
      Provide.value<CommentListModule>(context).getComment(up);
    }, controller,
        enableLoadMore: mode?.comment?.hasNext ?? false, autoLoad: mode?.comment?.hasNext ?? false);
  }

  @override
  void onFirstInit() {
    Provide.value<CommentListModule>(context).getComment(true);
  }
}
