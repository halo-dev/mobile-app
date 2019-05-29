import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:halo/app/config.dart';

final TextStyle style = TextStyle(fontSize: 16, color: Config.fontColor);

buildAvatarTextItem(String name, String data, Function click, {bool avatar = false}) {
  return Material(
    color: Colors.white,
    child: InkWell(
      onTap: click,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 13, 5, 13),
        child: Row(children: [
          Text(name, style: style),
          avatar
              ? Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[_buildAvatar(data)]))
              : Expanded(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      data,
                      style: style,
                    ),
                  ],
                )),
          Icon(Icons.keyboard_arrow_right, size: 25, color: Config.fontColor),
        ]),
      ),
    ),
  );
}

ClipOval _buildAvatar(String data) {
  return ClipOval(
    child: CachedNetworkImage(
      height: 50,
      width: 50,
      fit: BoxFit.cover,
      imageUrl: data,
      placeholder: (context, url) => new CircularProgressIndicator(),
      errorWidget: (context, url, error) => Image.asset(
            "assest/images/halo_avatar.png",
            width: 50,
            height: 50,
          ),
    ),
  );
}
