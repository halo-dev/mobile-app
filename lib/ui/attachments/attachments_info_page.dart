import 'package:flutter/material.dart';
import 'package:halo/app/base/base_widget.dart';
import 'package:halo/app/config.dart' as cf;
import 'package:halo/app/provide.dart';
import 'package:halo/ui/attachments/attach_item.dart';
import 'package:halo/ui/attachments/attachments_manager_model.dart';
import 'package:halo/ui/post/edit/edit_page.dart';
import 'package:halo/ui/post/list/search_post_list_page.dart';
import 'package:halo/util/Utils.dart';
import 'package:halo/widget/loading_dialog.dart';
import 'package:halo/widget/refresh_list.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AttachmentsListPage extends BaseState with PullRefreshMixIn {
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
        title: Text("媒体管理"),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {
                pushToNewPage(context, SearchPostListPage());
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.file_upload,
          size: 24,
          color: Colors.white,
        ),
        tooltip: "发布新文章",
        onPressed: () {
          pushToNewPage(context, EditPostPage(false, null));
        },
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 0, 135, 190),
        elevation: 5.0,
        highlightElevation: 10.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Provide<AttachmentsModule>(builder: (context, child, mode) {
        return _buildList(context, mode);
      }),
    );
  }

  @override
  void onFirstInit() {
    refresh(true);
  }

  void refresh(bool refresh) {
    Provide.value<AttachmentsModule>(context).getAttachment(refresh);
  }

  Widget _buildList(BuildContext context, AttachmentsModule mode) {
    finishRefresh(controller);
    IndexedWidgetBuilder builder;
    if (mode.attachments == null || mode.attachments.isEmpty) {
      builder = (BuildContext context, int index) {
        return loadWithStatus(mode.status);
      };
    } else {
      builder = (BuildContext context, int index) {
        return AttachListItem(mode.attachments.content[index]);
      };
    }
    return buildRefresh(
        GridView.builder(
          itemCount: mode?.attachments?.content?.length ?? 1,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, //横轴三个子widget
              childAspectRatio: 1 //宽高比为1时，子widget
              ),
          itemBuilder: builder,
        ), (up) {
      refresh(up);
    }, controller);
  }
}
