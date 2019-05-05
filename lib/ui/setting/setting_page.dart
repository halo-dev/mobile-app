import 'package:flutter/material.dart';
import 'package:halo/app/config.dart';
import 'package:halo/app/module/site_module.dart';
import 'package:halo/app/provide.dart';
import 'package:halo/widget/login_text_field.dart';

class SettingPage extends StatelessWidget {
  TextStyle style = TextStyle(fontSize: 16, color: Color.fromARGB(255, 102, 142, 170));
  final TextEditingController _userCtl = new TextEditingController();
  final TextEditingController _passwdCtl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Provide<SiteModule>(builder: (context, child, site) {
      _userCtl.text = site.site.username;
      return Scaffold(
        backgroundColor: Config.background,
        appBar: AppBar(
          title: Text(site.site.title),
          actions: <Widget>[
            IconButton(
              // action button
              icon: new Icon(Icons.check),
              onPressed: () {},
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("账户", style: style),
              loginTextField("用户名", _userCtl, null),
              loginTextField("密码", _passwdCtl, null, show: true),
            ],
          ),
        ),
      );
    });
  }
}
