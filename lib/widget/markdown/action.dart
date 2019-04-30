import 'dart:async';

import 'package:flutter/material.dart';
import 'package:halo/widget/popup/over.dart';

///  Action image button of markdown editor.
class ActionImage extends StatefulWidget {
  ActionImage({
    Key key,
    this.type,
    this.tap,
    this.imageSelect,
  }) : super(key: key);

  final ActionType type;
  final TapFinishCallback tap;
  final ImageSelectCallback imageSelect;

  @override
  ActionImageState createState() => ActionImageState();
}

class ActionImageState extends State<ActionImage> {
  String _getImagePath() {
    return _defaultImageAttributes.firstWhere((img) => img.type == widget.type)?.path;
  }

  void _disposeActionList(ActionType type) {
    var firstWhere = _defaultImageAttributes.firstWhere((data) => data.type == type);
    widget.tap(firstWhere.text, firstWhere.positionReverse);
  }

  void _disposeAction() {
    var firstWhere = _defaultImageAttributes.firstWhere((img) => img.type == widget.type);
    if (widget.tap != null && firstWhere != null) {
      if (firstWhere.type == ActionType.image) {
        if (widget.imageSelect != null) {
          widget.imageSelect().then(
            (str) {
              if (str != null && str.isNotEmpty) {
                // 延迟执行它，现在不确定为什么没有执行成功
                // 它不是没有被执行，而是在[tap]方法中无法获取光标位置
                // 我怀疑跟界面切换有关，可能在选择图片后，[TextField]还未立即获得焦点。
                // 当然，这只是零时解决方案。
                Timer(const Duration(milliseconds: 1000), () {
                  widget.tap('![]($str)', 0);
                });
              }
            },
            onError: print,
          );
          return;
        }
      }
      widget.tap(firstWhere.text, firstWhere.positionReverse);
    }
  }

  GlobalKey anchorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    if (widget.type == ActionType.h1) {
      return InkWell(
          onTap: () {
            RenderBox renderBox = anchorKey.currentContext.findRenderObject();
//            var offset = renderBox.localToGlobal(Offset(0.0, renderBox.size.height));
            var offset = renderBox.localToGlobal(Offset.zero);
            Size size = MediaQuery.of(context).size;

            int listHeight = _HeadingList().length * 40;
            var bottom = size.height - (offset.dy - 10);
            var top = size.height - (bottom + listHeight);

            var padding =
                EdgeInsets.fromLTRB(offset.dx - 40, top, size.width - offset.dx - 80, bottom);
            ShowOverlayPop pop = ShowOverlayPop(context, padding);
            pop.createView(
              Container(
                  color: Colors.white,
                  child: Material(
                    elevation: 2,
                    child: Column(
                      children: _HeadingList(),
                    ),
                  )),
            );
          },
          child: Image(
            key: anchorKey,
            color: Color.fromARGB(255, 135, 166, 188),
            width: 25.0,
            height: 25.0,
            image: AssetImage("assest/images/font.png"),
          ));
    } else {
      return IconButton(
        icon: Image(
          color: Color.fromARGB(255, 135, 166, 188),
          width: 25.0,
          height: 25.0,
          image: AssetImage(_getImagePath()),
        ),
        tooltip: _defaultImageAttributes.firstWhere((img) => img.type == widget.type)?.tip,
        onPressed: _disposeAction,
      );
    }
  }

  int groupValue = 1;

  List<Widget> _HeadingList() {
    return <Widget>[
      InkWell(
        child: createItem("assest/images/font.png", "default"),
        onTap: () {
          _disposeActionList(ActionType.h1);
        },
      ),
      InkWell(
        child: createItem("assest/images/h1.png", "Heading 1"),
        onTap: () {
          _disposeActionList(ActionType.h1);
        },
      ),
      InkWell(
        child: createItem("assest/images/h2.png", "Heading 2"),
        onTap: () {
          _disposeActionList(ActionType.h2);
        },
      ),
      InkWell(
        child: createItem("assest/images/h3.png", "Heading 3"),
        onTap: () {
          _disposeActionList(ActionType.h3);
        },
      ),
      InkWell(
        child: createItem("assest/images/h4.png", "Heading 4"),
        onTap: () {
          _disposeActionList(ActionType.h4);
        },
      ),
      InkWell(
        child: createItem("assest/images/h5.png", "Heading 5"),
        onTap: () {
          _disposeActionList(ActionType.h5);
        },
      )
    ];
  }

  Widget createItem(String image, String text) {
    return SizedBox(
        height: 40,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [
              Expanded(
                child: text == "default"
                    ? Text(
                        text,
                        style: TextStyle(color: Color.fromARGB(255, 135, 166, 188), fontSize: 16),
                      )
                    : Image.asset(
                        image,
                        color: Color.fromARGB(255, 135, 166, 188),
                        width: 25.0,
                        height: 20.0,
                      ),
              ),
              Checkbox(
                  value: text == "default" ? true : false,
                  onChanged: null,
                  checkColor: Color.fromARGB(255, 135, 166, 188),
                  activeColor: Color.fromARGB(255, 135, 166, 188)),
            ],
          ),
        ));
  }
}

const _defaultImageAttributes = <ImageAttributes>[
  ImageAttributes(
    type: ActionType.h1,
    path: 'assest/images/h1.png',
    text: '\n# ',
    tip: '一级标题',
    positionReverse: 0,
  ),
  ImageAttributes(
    type: ActionType.h2,
    path: 'assest/images/h2.png',
    text: '\n## ',
    tip: '二级标题',
    positionReverse: 0,
  ),
  ImageAttributes(
    type: ActionType.h3,
    path: 'assest/images/h3.png',
    text: '\n### ',
    tip: '三级标题',
    positionReverse: 0,
  ),
  ImageAttributes(
    type: ActionType.undo,
    path: 'assest/images/undo_img.png',
    tip: '撤销',
  ),
  ImageAttributes(
    type: ActionType.redo,
    path: 'assest/images/redo_img.png',
    tip: '恢复',
  ),
  ImageAttributes(
    type: ActionType.image,
    path: 'assest/images/picture.png',
    text: '![]()',
    tip: '图片',
    //assest/assest/imagesedit_img.png
    positionReverse: 3,
  ),
  ImageAttributes(
    type: ActionType.link,
    path: 'assest/images/link.png',
    text: '[]()',
    tip: '链接',
    positionReverse: 3,
  ),
  ImageAttributes(
    type: ActionType.fontBold,
    path: 'assest/images/font-bold.png',
    text: '****',
    tip: '加粗',
    positionReverse: 2,
  ),
  ImageAttributes(
    type: ActionType.fontItalic,
    path: 'assest/images/font-italic.png',
    text: '**',
    tip: '斜体',
    positionReverse: 1,
  ),
  ImageAttributes(
    type: ActionType.h4,
    path: 'assest/images/h4.png',
    text: '\n#### ',
    tip: '四级标题',
    positionReverse: 0,
  ),
  ImageAttributes(
    type: ActionType.h5,
    path: 'assest/images/h5.png',
    text: '\n##### ',
    tip: '五级标题',
    positionReverse: 0,
  ),
//  ImageAttributes(
//    type: ActionType.fontDeleteLine,
//    path: 'assest/images/strikethrough_img.png',
//    text: '~~~~',
//    tip: '删除线',
//    positionReverse: 2,
//  ),
  ImageAttributes(
    type: ActionType.textQuote,
    path: 'assest/images/format_quote_img.png',
    text: '\n>',
    tip: '文字引用',
    positionReverse: 0,
  ),
  ImageAttributes(
    type: ActionType.list,
    path: 'assest/images/list_img.png',
    text: '\n- ',
    tip: '无序列表',
    positionReverse: 0,
  ),
  ImageAttributes(
    type: ActionType.code,
    path: 'assest/images/code_img.png',
    text: '\n```\n\n```',
    tip: '代码',
    positionReverse: 4,
  ),
];

enum ActionType {
  undo,
  redo,
  image,
  link,
  fontBold,
  fontItalic,
  fontDeleteLine,
  textQuote,
  list,
  h1,
  h2,
  h3,
  h4,
  h5,
  code,
}

class ImageAttributes {
  const ImageAttributes({
    this.tip = '',
    this.text,
    this.positionReverse,
    @required this.type,
    @required this.path,
  })  : assert(path != null),
        assert(type != null);

  final ActionType type;
  final String path;
  final String tip;
  final String text;
  final int positionReverse;
}

/// Call this method after clicking the [ActionImage] and completing a series of actions.
/// [text] Adding text.
/// [position] Cursor position that reverse order.
typedef TapFinishCallback(String text, int positionReverse);

/// Call this method after clicking the ImageAction.
/// return your select image path.
typedef Future<String> ImageSelectCallback();
