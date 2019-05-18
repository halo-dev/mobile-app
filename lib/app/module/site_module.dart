import 'package:flutter/material.dart';
import 'package:halo/app/config.dart';
import 'package:halo/app/module/site.dart';
import 'package:halo/util/sp_util.dart';
import 'package:halo/util/string_util.dart';

class SiteModule extends ChangeNotifier {
  Site _site;

  Site get site => _site;

  void change(Site newSite) {
    SPUtil.delete(Config.SpKey);
    //保存新的
    this._site = newSite;
    SPUtil.save(Config.SpKey, _site.toString());
    notifyListeners();
  }

  void loadData() {
    SPUtil.get(Config.SpKey).then((json) {
      if (isNotEmpty(json)) {
        _site = Site(json);
        notifyListeners();
      }
    });
  }

  void saveSite(Site site) {
    SPUtil.save(Config.SpKey, site.toString());
  }

  void updateUserInfo(String avatar, String nickname, String username) {
    site.avatar = avatar;
    site.nickname = nickname;
    site.username = username;
    change(site);
  }
}
