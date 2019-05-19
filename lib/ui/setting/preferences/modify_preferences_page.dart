import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:halo/app/base/base_widget.dart';
import 'package:halo/app/config.dart';
import 'package:halo/app/provide.dart';
import 'package:halo/module/user/profile.dart';
import 'package:halo/ui/setting/preferences/set_user_preferences_module.dart';
import 'package:halo/util/Utils.dart';
import 'package:halo/widget/login_text_field.dart';

const int mail = 0x000234;
const int name = 0x000235;
const int nick = 0x000236;
const int info = 0x000237;
const int pwd = 0x000238;

class ModifyPreferences extends BaseState {
  final int type;
  final HashMap<int, String> titleMap = HashMap()
    ..[mail] = "邮箱"
    ..[name] = "用户名"
    ..[nick] = "昵称"
    ..[info] = "个人说明"
    ..[pwd] = "密码";

  ModifyPreferences(this.type);

  final TextEditingController _textController = new TextEditingController();
  final TextEditingController _pwdController = new TextEditingController();
  final TextEditingController _confirmController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.background,
      appBar: AppBar(
        elevation: 0,
        title: Text("修改${titleMap[type]}"),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.done,
                color: Colors.white,
              ),
              onPressed: () {
                if (type != pwd) {
                  if (isEmpty(_textController.text)) {
                    ToastUtil.showToast("你似乎什么都没有写...");
                    return;
                  }
                  Profile profile = Provide.value<SetUserPreferencesModule>(context).profile;
                  var saveData = _textController.text;
                  switch (type) {
                    case mail:
                      profile.email = saveData;
                      break;
                    case name:
                      profile.username = saveData;
                      break;
                    case nick:
                      profile.nickname = saveData;
                      break;
                    case info:
                      profile.description = saveData;
                      break;
                  }
                  Provide.value<SetUserPreferencesModule>(context).update(profile, context);
                } else {
                  var _old = _textController.text;
                  var _pwd = _pwdController.text;
                  var _confirm = _confirmController.text;

                  if (isEmpty(_old) || isEmpty(_pwd) || isEmpty(_confirm)) {
                    ToastUtil.showToast("请完善信息后在提交...");
                    return;
                  }
                  if (_pwd != _confirm) {
                    ToastUtil.showToast("新密码两次输入不一致");
                    return;
                  }
                  if (_pwd != _old) {
                    ToastUtil.showToast("新密码和旧密码不能相同");
                    return;
                  }
                  Provide.value<SetUserPreferencesModule>(context)
                      .updatePasswd(_old, _pwd, context);
                }
              })
        ],
      ),
      body: Provide<SetUserPreferencesModule>(builder: (context, child, mode) {
        return _buildBody(context, mode);
      }),
    );
  }

  @override
  void onFirstInit() {}

  Widget _buildBody(BuildContext context, SetUserPreferencesModule mode) {
    if (type == pwd) {
      return Container(
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(8, 0, 8, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              loginTextField("原密码", _textController, null,
                  inputType: TextInputType.emailAddress, show: true, action: TextInputAction.next),
              loginTextField("新密码", _pwdController, null,
                  inputType: TextInputType.emailAddress, show: true, action: TextInputAction.next),
              loginTextField("确认密码", _confirmController, null,
                  show: true, inputType: TextInputType.emailAddress),
            ],
          ));
    } else {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(8, 0, 8, 5),
        child: loginTextField("修改${titleMap[type]}", _textController, null,
            minLine: type == info ? 10 : 1, helperText: getData(type, mode.profile)),
      );
    }
  }

  String getData(int type, Profile profile) {
    switch (type) {
      case mail:
        return profile.email;
      case name:
        return profile.username;
      case nick:
        return profile.nickname;
      case info:
        return profile.description;
    }
  }
}
