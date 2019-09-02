import 'package:flutter/material.dart';
import 'package:halo/app/config.dart';
import 'package:halo/ui/login/login_to_site.dart';
import 'package:halo/util/string_util.dart';
import 'package:halo/widget/login_text_field.dart';
import 'package:toast/toast.dart';

class SiteLogin extends StatelessWidget {
  final TextEditingController _addressCtl = new TextEditingController();
  final TextEditingController _userCtl = new TextEditingController();
  final TextEditingController _passwdCtl = new TextEditingController();

  bool newSite = false;

  SiteLogin({this.newSite});

  @override
  Widget build(BuildContext context) {
    if (newSite != null && newSite) {
      _addressCtl.text = "";
      _userCtl.text = "";
      _passwdCtl.text = "";
    }
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assest/images/halo.png",
          color: Colors.white,
          height: 45,
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Config.background,
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "输入您要连接的Halo站点",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            loginTextField(
                "站点地址", _addressCtl, "assest/images/site_address.png"),
            loginTextField("用户名", _userCtl, "assest/images/user_name.png"),
            loginTextField("密码", _passwdCtl, "assest/images/password.png",
                show: true),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  color: Colors.lightBlue,
                  textColor: Colors.white,
                  onPressed: () {
                    _ToNewPage(context);
                  },
                  child: Text("下一步"),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }

  void _ToNewPage(BuildContext context) {
    var address = _addressCtl.text;
    var user = _userCtl.text;
    var passwd = _passwdCtl.text;
    //登陆
    if (isEmpty(address) || isEmpty(user) || isEmpty(passwd)) {
      Toast.show("请完善站点信息", context, gravity: 1);
    } else {
      LoginToSite().login(address, user, passwd, context);
//      pushToNewPage(context, SiteInfo(address, user, passwd));
    }
  }
}
