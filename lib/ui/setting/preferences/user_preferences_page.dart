import 'package:flutter/material.dart';
import 'package:halo/app/base/base_widget.dart';
import 'package:halo/app/config.dart' as cf;
import 'package:halo/app/provide.dart';
import 'package:halo/module/user/profile.dart';
import 'package:halo/ui/attachments/attachments_list_page.dart';
import 'package:halo/ui/setting/preferences/modify_preferences_page.dart';
import 'package:halo/ui/setting/preferences/set_user_preferences_module.dart';
import 'package:halo/util/Utils.dart';
import 'package:halo/widget/avatar_text_set.dart';
import 'package:halo/widget/loading_dialog.dart';
import 'package:halo/widget/refresh_list.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SetUserPreferences extends BaseState with PullRefreshMixIn {
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
        title: Text("个人资料"),
      ),
      body: Provide<SetUserPreferencesModule>(builder: (context, child, mode) {
        return _buildBody(context, mode);
      }),
    );
  }

  @override
  void onFirstInit() {
    Provide.value<SetUserPreferencesModule>(context).getUserInfo();
  }

  Widget _buildBody(BuildContext context, SetUserPreferencesModule mode) {
    finishRefresh(controller);
    IndexedWidgetBuilder builder;
    if (mode.profile == null) {
      builder = (BuildContext context, int index) {
        return loadWithStatus(mode.status);
      };
    } else {
      builder = (BuildContext context, int index) {
        return _buildProfile(mode.profile);
      };
    }
    return buildRefresh(builderList(1, builder), (up) {
      Provide.value<SetUserPreferencesModule>(context).getUserInfo();
    }, controller);
  }

  _buildProfile(Profile profile) {
    return Column(children: [
      buildAvatarTextItem("个人头像", profile.avatar, () async {
        String path = await pushToNewPageWithWidget(context, AttachmentsListPage.byType(avatar));
        if (isNotEmpty(path)) {
          profile.avatar = path;
          Provide.value<SetUserPreferencesModule>(context).update(profile, context, back: false);
        }
      }, avatar: true),
      Divider(height: 1),
      buildAvatarTextItem("用户名：", profile.username, () => pushToEdit(name)),
      Divider(height: 1),
      buildAvatarTextItem("昵称：", profile.nickname, () => pushToEdit(nick)),
      Divider(height: 1),
      buildAvatarTextItem("密码修改：", "", () => pushToEdit(pwd)),
      Divider(height: 1),
      buildAvatarTextItem("邮箱：", profile.email, () => pushToEdit(mail)),
      Divider(height: 1),
      buildAvatarTextItem("个人说明：", profile.description, () => pushToEdit(info)),
      Divider(height: 1)
    ]);
  }

  Future pushToEdit(int type) => pushToNewPageWithWidget(context, ModifyPreferences(type));
}
