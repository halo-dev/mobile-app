import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halo/app/config.dart';
import 'package:halo/app/module/site.dart';
import 'package:halo/app/module/site_module.dart';
import 'package:halo/app/provide.dart';
import 'package:halo/ui/login/site_login.dart';
import 'package:halo/ui/main/main_page.dart';
import 'package:halo/ui/main/site_view.dart';
import 'package:halo/util/jump_page.dart';
import 'package:halo/util/sp_util.dart';

class SiteInfo extends StatelessWidget {
  String address;
  String userName;
  String passwd;

  SiteInfo(this.address, this.userName, this.passwd);

  Color loginInfoFont = Color.fromARGB(255, 85, 123, 149);
  String icon = "https://secure.gravatar.com/avatar/a08917f5098953adef7dbb3f09641b65";

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      color: Config.background,
      padding: EdgeInsets.fromLTRB(10, 40, 10, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            " 登陆身份为",
            style: TextStyle(fontSize: 15, color: loginInfoFont),
          ),
          SizedBox(
            height: 10,
          ),
          Card(
              elevation: 2,
              child: SizedBox(
                height: 170,
                child: Align(
                    alignment: Alignment.center,
//                      mainAxisAlignment: MainAxisAlignment.end,
//                      crossAxisAlignment: CrossAxisAlignment.center,
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(icon),
                            radius: 60,
                          ),
                        ),
                        Text(
                          userName,
                          style: TextStyle(
                              height: 2,
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: loginInfoFont),
                        ),
                        Text(
                          "@$userName",
                          style: TextStyle(fontSize: 15, color: loginInfoFont),
                        ),
                      ],
                    )),
              )),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 30, 0, 0),
            child: Text(
              "我的站点",
              style: TextStyle(fontSize: 15, color: loginInfoFont),
            ),
          ),
          SiteView(icon, userName, address),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                        child: RaisedButton(
                      color: Colors.white,
                      textColor: Colors.lightBlue,
                      onPressed: () {
                        pushToNewPage(
                            context,
                            SiteLogin(
                              newSite: true,
                            ));
                      },
                      child: Text("连接其他站点"),
                    ))
                  ]),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                Expanded(
                    child: RaisedButton(
                  color: Colors.lightBlue,
                  textColor: Colors.white,
                  onPressed: () {
                    _saveSiteToMain(context);
                  },
                  child: Text("继续"),
                ))
              ])
            ],
          ))
        ],
      ),
    ));
  }

  void _saveSiteToMain(BuildContext context) {
    Site site = Site.fromParams(
        password: passwd, account: userName, address: address, icon: icon, title: userName);
    SPUtil.save(Config.SpKey, site.toString());
    Provide.value<SiteModule>(context).loadData();

    Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (BuildContext context) {
      return MainPage();
    }), (Route<dynamic> route) => false);
  }
}
