import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:halo/app/base/base_widget.dart';
import 'package:halo/app/provide.dart';
import 'package:halo/module/attachments.dart';
import 'package:halo/ui/attachments/attachments_manager_model.dart';
import 'package:halo/util/Utils.dart';
import 'package:halo/widget/alertdialog.dart';
import 'package:halo/widget/extended_image/extended_image.dart';
import 'package:intl/intl.dart';

/// 预览图
class PreviewImagePage extends BaseState with SingleTickerProviderStateMixin {
  final int index;

  PreviewImagePage(this.index);

  var rebuild = StreamController<int>.broadcast();
  AnimationController _animationController;
  Function animationListener;
  Animation<double> _animation;

  @override
  void initState() {
    currentIndex = index;
    _animationController =
        AnimationController(duration: const Duration(milliseconds: 150), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    rebuild.close();
    _animationController?.dispose();
    clearGestureDetailsCache();
    super.dispose();
  }

//  CancellationToken _cancelToken;
//  CancellationToken get cancelToken {
//    if (_cancelToken == null || _cancelToken.isCanceled)
//      _cancelToken = CancellationToken();
//
//    return _cancelToken;
//  }
  List<double> doubleTapScales = <double>[1.0, 2.0];

  int currentIndex;
  bool showInfo = false;
  String title = "";

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.black,
        child: Column(
          children: <Widget>[
            Provide<AttachmentsModule>(builder: (context, child, mode) {
              return buildBody(mode.attachments.content);
            }),
          ],
        ));
  }

  Expanded buildBody(List<AttachmentsContent> pics) {
    return Expanded(
        child: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        ExtendedImageGesturePageView.builder(
          itemBuilder: (BuildContext context, int index) {
            var item = pics[index].path;
//            Widget image = buildCachedNetworkImage(item, fit: BoxFit.contain);
            Widget image = ExtendedImage(
              image: CachedNetworkImageProvider(item),
              fit: BoxFit.contain,
              //cancelToken: cancelToken,
              //autoCancel: false,
              mode: ExtendedImageMode.Gesture,
              gestureConfig: GestureConfig(
                  inPageView: true,
                  initialScale: 1.0,
                  maxScale: 5.0,
                  animationMaxScale: 5.0,
                  //you can cache gesture state even though page view page change.
                  //remember call clearGestureDetailsCache() method at the right time.(for example,this page dispose)
                  cacheGesture: false),
              onDoubleTap: (ExtendedImageGestureState state) {
                ///you can use define pointerDownPosition as you can,
                ///default value is double tap pointer down postion.
                var pointerDownPosition = state.pointerDownPosition;
                double begin = state.gestureDetails.totalScale;
                double end;

                //remove old
                _animation?.removeListener(animationListener);

                //stop pre
                _animationController.stop();

                //reset to use
                _animationController.reset();

                if (begin == doubleTapScales[0]) {
                  end = doubleTapScales[1];
                } else {
                  end = doubleTapScales[0];
                }

                animationListener = () {
                  //print(_animation.value);
                  state.handleDoubleTap(
                      scale: _animation.value, doubleTapPosition: pointerDownPosition);
                };
                _animation = _animationController.drive(Tween<double>(begin: begin, end: end));

                _animation.addListener(animationListener);

                _animationController.forward();
              },
            );
            image = Container(
              child: image,
//              padding: EdgeInsets.all(5.0),
            );
            if (index == currentIndex) {
              return Hero(
                tag: item + index.toString(),
                child: image,
              );
            } else {
              return image;
            }
          },
          itemCount: pics.length,
          onPageChanged: (int index) {
            currentIndex = index;
            rebuild.add(index);
          },
          controller: PageController(
            initialPage: currentIndex,
          ),
          scrollDirection: Axis.horizontal,
        ),
        Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: MySwiperPlugin(pics, currentIndex, rebuild),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0.0,
          height: MediaQuery.of(context).padding.top + 48,
          child: AppBar(
            backgroundColor: Colors.transparent,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.info_outline, size: 24, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      showInfo = !showInfo;
                    });
                  })
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          height: showInfo ? MediaQuery.of(context).size.height : 0,
          width: showInfo ? MediaQuery.of(context).size.width : 0,
          child: InkWell(
            onTap: () {
              setState(() {
                showInfo = !showInfo;
              });
            },
            child: Container(
//              padding: EdgeInsets.fromLTRB(16, MediaQuery.of(context).padding.top, 16, 0),
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              color: Colors.transparent.withOpacity(0.5),
              child: new Column(
                children: [
                  _buildInfo("附件名：", "${pics[currentIndex].name}.${pics[currentIndex].suffix}"),
                  _buildInfo("附件类型：", pics[currentIndex].mediaType),
                  _buildInfo("存储位置：", pics[currentIndex].type),
                  _buildInfo("附件大小：", FileUtil.getRollupSize(pics[currentIndex].size)),
                  _buildInfo("图片尺寸：", "${pics[currentIndex].width}x${pics[currentIndex].height}"),
                  _buildInfo(
                      "上传日期：",
                      DateFormat("yyyy.MM.dd HH:mm").format(
                          DateTime.fromMillisecondsSinceEpoch(pics[currentIndex].createTime))),
                  _buildInfo("链接：", pics[currentIndex].path),
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }

  @override
  void onFirstInit() {
    // TODO: implement onFirstInit
  }
}

_buildInfo(String name, String info) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(children: <Widget>[
      Expanded(
        child: Text(name, style: TextStyle(color: Colors.white, fontSize: 15)),
      ),
      Expanded(
        child: Text(info, style: TextStyle(color: Colors.white, fontSize: 15)),
        flex: 3,
      )
    ]),
  );
}

Padding _buildIcon(url, double size, {Color color}) => Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
      child: Image.asset(
        url,
        width: size,
        height: size,
        color: color ?? Colors.white,
      ),
    );

class MySwiperPlugin extends StatelessWidget {
  final List<AttachmentsContent> pics;
  final int index;
  final StreamController<int> reBuild;

  MySwiperPlugin(this.pics, this.index, this.reBuild);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      builder: (BuildContext context, data) {
        var item = pics[data.data];
        return DefaultTextStyle(
          style: TextStyle(color: Colors.blue),
          child: Container(
            height: 48,
            color: Colors.grey.withOpacity(0.2),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                          child: Icon(Icons.delete, size: 25, color: Colors.red),
                          onTap: () {
                            AlertContentDialog(context, "删除文件", () {
                              Provide.value<AttachmentsModule>(context).delete(item.id);
                            }, Text("确定要删除文件 ${item.name} 吗？"));
                          })
                    ],
                  )),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          child: _buildIcon("assest/images/copy_url.png", 20),
                          onTap: () {
                            Clipboard.setData(new ClipboardData(text: item.path));
                            ToastUtil.showToast("图片链接已复制到粘贴板");
                          }),
                      InkWell(
                          child: _buildIcon("assest/images/file_markdown.png", 35),
                          onTap: () {
                            Clipboard.setData(new ClipboardData(
                                text: "![${item.name}.${item.suffix}](${item.path})"));
                            ToastUtil.showToast("图片的Markdown链接已复制到粘贴板");
                          })
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
      initialData: index,
      stream: reBuild.stream,
    );
  }
}
