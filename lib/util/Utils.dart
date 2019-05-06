import 'package:flutter/material.dart';
import 'package:halo/app/config.dart';
import 'package:halo/app/module/site.dart';
import 'package:halo/module/user/token.dart';
import 'package:halo/util/Utils.dart';
import 'package:intl/intl.dart';

export 'color_util.dart';
export 'default_bus.dart';
export 'jump_page.dart';
export 'log_util.dart';
export 'sp_util.dart';
export 'string_util.dart';
export 'toast.dart';

class Utils {
  static Color nameToColor(String name) {
// assert(name.length > 1);
    final int hash = name.hashCode & 0xffff;
    final double hue = (360.0 * hash / (1 << 15)) % 360.0;
    return HSVColor.fromAHSV(1.0, hue, 0.4, 0.90).toColor();
  }

  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static updateSite(Token token) {
    SPUtil.get(Config.SpKey).then((json) {
      if (isNotEmpty(json)) {
        var _site = Site(json);
        _site.refreshToken = token.refresh_token;
        _site.accessToken = token.access_token;
        _site.expired = token.expired_in;
        SPUtil.save(Config.SpKey, _site.toString());
      }
    });
  }

  static String getFormattedTime(int milliseconds) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    var now = DateTime.now();

    var diff = Duration(milliseconds: now.millisecondsSinceEpoch - dateTime.millisecondsSinceEpoch);
    if (diff.inMinutes < 1) {
      return "刚刚";
    }
    if (diff.inMinutes <= 60) {
      return "${diff.inMinutes}分钟前";
    }
    if (diff.inHours <= 24) {
      return "${diff.inHours}小时前";
    }
    if (diff.inDays <= 5) {
      return "${diff.inDays}天前";
    }
    return DateFormat("y年M月d日").format(dateTime);
  }
}
