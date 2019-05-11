import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:halo/app/config.dart';
import 'package:halo/module/attachments.dart';

class AttachListItem extends StatelessWidget {
  final AttachmentsContent item;

  AttachListItem(this.item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if (item.mediaType.contains("image")) {
            /// 可查看大图
          }
        },
        child: Card(
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                right: 0,
                bottom: 0,
                left: 0,
                child: CachedNetworkImage(
                    imageUrl: item.thumbPath,
                    fit: BoxFit.fill,
                    placeholder: (context, url) => new CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error_outline, size: 30, color: Config.fontLightColor)),
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          icon: Icon(Icons.info_outline, size: 24, color: Colors.white),
                          onPressed: null)
                    ],
                  )),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 40,
                  color: Colors.black26,
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          child: _buildIcon("assest/images/copy_url.png"),
                          onTap: () {
                            Clipboard.setData(new ClipboardData(text: item.path));
                          }),
                      InkWell(
                          child: _buildIcon("assest/images/file_markdown.png"),
                          onTap: () {
                            Clipboard.setData(new ClipboardData(
                                text: "![${item.name}.${item.suffix}](${item.path})"));
                          })
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Padding _buildIcon(url) => Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
        child: Image.asset(
          url,
          width: 20,
          height: 20,
          color: Colors.white,
        ),
      );
}
