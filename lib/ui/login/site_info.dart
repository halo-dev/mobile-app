import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halo/app/config.dart';
import 'package:halo/app/module/site.dart';
import 'package:halo/app/module/site_module.dart';
import 'package:halo/app/provide.dart';
import 'package:halo/app/request_info.dart';
import 'package:halo/module/user/profile.dart';
import 'package:halo/module/user/token.dart';
import 'package:halo/ui/login/site_login.dart';
import 'package:halo/ui/main/main_page.dart';
import 'package:halo/ui/main/site_view.dart';
import 'package:halo/util/jump_page.dart';

class SiteInfo extends StatelessWidget {
  Profile profile;
  Token token;
  String title;

  SiteInfo(this.profile, this.token, this.title);

  Color loginInfoFont = Color.fromARGB(255, 85, 123, 149);

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
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: CachedNetworkImage(
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                            imageUrl: profile.avatar,
                            placeholder: (context, url) => new CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Image.asset(
                                  "assest/images/halo_avatar.png",
                                  width: 50,
                                  height: 50,
                                ),
                          ),
                        ),
                        Text(
                          profile.username,
                          style: TextStyle(
                              height: 2,
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: loginInfoFont),
                        ),
                        Text(
                          "@${profile.nickname}",
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
          SiteView(profile.avatar, title, RequestInfo().HOST),
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
        accessToken: token.access_token,
        refreshToken: token.refresh_token,
        host: RequestInfo().HOST,
        username: profile.username,
        nickname: profile.nickname,
        expired: token.expired_in,
        avatar: profile.avatar,
        title: title);
    Provide.value<SiteModule>(context).saveSite(site);
    Provide.value<SiteModule>(context).loadData();
    Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (BuildContext context) {
      return MainPage();
    }), (Route<dynamic> route) => false);
  }
}
