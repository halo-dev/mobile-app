import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:halo/module/attachments.dart';
import 'package:halo/ui/attachments/preview/preview_images.dart';
import 'package:halo/ui/attachments/preview/preview_images_page.dart';
import 'package:halo/util/Utils.dart';

class AttachListItem extends StatelessWidget {
  final AttachmentsContent item;
  final int index;

  AttachListItem(this.item, this.index);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if (item.mediaType.contains("image")) {
            /// 可查看大图
            pushToNewPageWithWidget(context, PreviewImagePage(index));
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
                child: buildCachedNetworkImage(item.thumbPath),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 40,
                  color: Colors.grey.withOpacity(0.2),
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
