import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:halo/app/base/base_widget.dart';
import 'package:halo/app/config.dart' as cf;
import 'package:halo/app/provide.dart';
import 'package:halo/module/user/profile.dart';
import 'package:halo/ui/attachments/attachments_info_page.dart';
import 'package:halo/ui/setting/preferences/modify_preferences_page.dart';
import 'package:halo/ui/setting/preferences/set_user_preferences_module.dart';
import 'package:halo/util/Utils.dart';
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
      _buildItem("个人头像", profile.avatar, () async {
        String path = await pushToNewPageWithWidget(context, AttachmentsListPage.byType(avatar));
        if (isNotEmpty(path)) {
          profile.avatar = path;
          Provide.value<SetUserPreferencesModule>(context).update(profile, context, back: false);
        }
      }, avatar: true),
      Divider(height: 1),
      _buildItem("用户名：", profile.username, () => pushToEdit(name)),
      Divider(height: 1),
      _buildItem("昵称：", profile.nickname, () => pushToEdit(nick)),
      Divider(height: 1),
      _buildItem("密码修改：", "", () => pushToEdit(pwd)),
      Divider(height: 1),
      _buildItem("邮箱：", profile.email, () => pushToEdit(mail)),
      Divider(height: 1),
      _buildItem("个人说明：", profile.description, () => pushToEdit(info)),
      Divider(height: 1)
    ]);
  }

  Future pushToEdit(int type) => pushToNewPageWithWidget(context, ModifyPreferences(type));

  final TextStyle style = TextStyle(fontSize: 16, color: cf.Config.fontColor);

  _buildItem(String name, String data, Function click, {bool avatar = false}) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: click,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 13, 16, 13),
          child: Row(children: [
            Expanded(child: Text(name, style: style)),
            avatar
                ? _buildAvatar(data)
                : Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          data,
                          style: style,
                        ),
                      ],
                    )),
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Icon(Icons.keyboard_arrow_right, size: 25, color: cf.Config.fontColor),
            )
          ]),
        ),
      ),
    );
  }

  ClipOval _buildAvatar(String data) {
    return ClipOval(
      child: CachedNetworkImage(
        height: 50,
        width: 50,
        fit: BoxFit.cover,
        imageUrl: data,
        placeholder: (context, url) => new CircularProgressIndicator(),
        errorWidget: (context, url, error) => Image.asset(
              "assest/images/halo_avatar.png",
              width: 50,
              height: 50,
            ),
      ),
    );
  }
}
