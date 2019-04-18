import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:halo/app/config.dart';

class SiteView extends StatelessWidget {
  String icon;
  String title;
  String address;
  EdgeInsetsGeometry padding;

  SiteView(this.icon, this.title, this.address, {this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding == null ? EdgeInsets.fromLTRB(5, 8, 5, 0) : padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CachedNetworkImage(
            height: 50,
            width: 50,
            imageUrl: icon,
            placeholder: (context, url) => new CircularProgressIndicator(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ),
          Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    softWrap: false,
                    style: TextStyle(
                        fontWeight: FontWeight.w900, height: 1.5, color: Config.fontColor),
                  ),
                  Text(
                    address,
                    style: TextStyle(height: 1.5, color: Config.fontColor),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
