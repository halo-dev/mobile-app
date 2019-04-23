import 'package:flutter/material.dart';

export 'color_util.dart';
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
}
