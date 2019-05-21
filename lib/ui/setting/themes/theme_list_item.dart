import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:halo/app/config.dart';
import 'package:halo/app/provide.dart';
import 'package:halo/module/themes.dart';
import 'package:halo/ui/setting/themes/set_themes_module.dart';
import 'package:halo/util/Utils.dart';
import 'package:halo/widget/loading_dialog.dart';

class ThemesListItem extends StatelessWidget {
  final Themes item;
  Color textColor = Color.fromARGB(255, 137, 137, 137);
  Color activated = Color.fromARGB(255, 0, 135, 190);

  ThemesListItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: CachedNetworkImage(
                imageUrl: item.screenshots,
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width - 20,
                placeholder: (context, url) => loading(),
                errorWidget: (context, url, error) =>
                    Icon(Icons.error_outline, size: 30, color: Config.fontLightColor)),
          ),
          Container(
            // 盒子样式
            padding: EdgeInsets.only(right: 10),
            color: Color.fromARGB(255, 243, 246, 248),
            child: Row(
              children: [
                _buildBtnIcon(
                    _buildIcon(
                      "assest/images/themes_activation.png",
                    ),
                    item.activated ? "已启用" : "启用", () {
                  if (item.activated) {
                    ToastUtil.showToast("主题已经启用");
                    return;
                  }
                  Provide.value<SetThemeModule>(context).activation(item.id);
                }),
                _buildBtnIcon(
                    _buildIcon(
                      "assest/images/delete_image.png",
                    ),
                    "删除", () {
                  Provide.value<SetThemeModule>(context).deleteTheme(item.id);
                }),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildIcon(icon) {
    return Image.asset(
      icon,
      height: 18,
      width: 18,
      color: item.activated ? activated : textColor,
    );
  }

  Widget _buildBtnIcon(icon, text, callBack) {
    return Expanded(
        child: InkWell(
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    icon,
                    const SizedBox(width: 3.0),
                    Text(
                      text,
                      style: TextStyle(color: item.activated ? activated : textColor, fontSize: 13),
                    ),
                  ],
                )),
            onTap: callBack));
  }
}
