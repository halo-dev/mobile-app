import 'package:halo/app/config.dart';
import 'package:halo/util/string_util.dart';

Log(dynamic value, {String key}) {
  if (Config.DEBUG) {
    print("debug");
    if (isNotEmpty(key))
      print('$key: $value');
    else
      print(value);
  } else
    print("debug2");
}
