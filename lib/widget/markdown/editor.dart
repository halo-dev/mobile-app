import 'package:flutter/material.dart';
import 'package:halo/widget/markdown/action.dart';
import 'package:halo/widget/markdown/edit_perform.dart';

class MdEditor extends StatefulWidget {
  MdEditor({
    Key key,
    this.titleStyle,
    this.padding = const EdgeInsets.all(0.0),
    this.initTitle,
    this.initText,
    this.hintTitle,
    this.hintText,
    this.imageSelect,
    this.textChange,
  }) : super(key: key);

  final TextStyle titleStyle;
  final EdgeInsetsGeometry padding;
  final String initTitle;
  final String initText;
  final String hintTitle;
  final String hintText;

  /// see [ImageSelectCallback]
  final ImageSelectCallback imageSelect;

  final VoidCallback textChange;

  @override
  State<StatefulWidget> createState() => MdEditorState();
}

class MdEditorState extends State<MdEditor> {
  final _titleEditingController = TextEditingController(text: '');
  final _textEditingController = TextEditingController(text: '');
  var _editPerform;
  var _maxLines = 14;

  String getTitle() {
    return _titleEditingController.value.text;
  }

  String getText() {
    return _textEditingController.value.text;
  }

  @override
  void initState() {
    super.initState();
    if (widget.initText != null && widget.initText.isNotEmpty) _maxLines = null;
    _titleEditingController.text = widget.initTitle ?? '';
    _textEditingController.text = widget.initText ?? '';

    _editPerform = EditPerform(
      _textEditingController,
      initText: _textEditingController.text,
    );
  }

  void _disposeText(String text, int index) {
    if (_textEditingController.selection.base.offset < 0) {
      print('WRAN: The value is ${_textEditingController.selection.base.offset}');
      return;
    }
    var startText =
        _textEditingController.text.substring(0, _textEditingController.selection.base.offset);
    var endText =
        _textEditingController.text.substring(_textEditingController.selection.base.offset);

    var str = startText + text + endText;
    _textEditingController.value = TextEditingValue(
        text: str,
        selection: TextSelection.collapsed(offset: startText.length + text.length - index));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: widget.padding,
              child: Column(
                children: <Widget>[
                  TextField(
                    maxLines: 1,
                    controller: _titleEditingController,
                    onChanged: (text) {
                      if (widget.textChange != null) widget.textChange();
                    },
                    style: widget.titleStyle ??
                        TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                          color: const Color.fromARGB(255, 135, 166, 188),
                        ),
                    decoration: InputDecoration(
                      hintText: widget.hintTitle ?? '标题',
                      border: InputBorder.none,
                    ),
                  ),
                  Container(
                    height: 1.0,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 232, 238, 242),
                    ),
                  ),
                  TextField(
                    maxLines: _maxLines,
                    controller: _textEditingController,
                    autofocus: true,
                    onChanged: (text) {
                      _editPerform.change(text);
                      if (_maxLines != null && text != null && text.length > _maxLines) {
                        setState(() {
                          _maxLines = null;
                        });
                      }
                      if (widget.textChange != null) widget.textChange();
                    },
                    decoration: InputDecoration(
                      hintText: widget.hintText ?? '请输入内容',
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 17.0,
                      height: 1.2,
                      color: const Color.fromARGB(255, 61, 89, 109),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            height: 40.0,
            width: MediaQuery.of(context).size.width,
            child: Ink(
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black54
                      : Color(0xFFF0F0F0),
                  boxShadow: [
                    BoxShadow(color: const Color(0xAAF0F0F0)),
                  ],
                  border: Border(
                      top: BorderSide(
                    color: Color.fromARGB(255, 135, 166, 188),
                  ))),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    ActionImage(
                      type: ActionType.undo,
                      tap: (s, i) {
                        _editPerform.undo();
                      },
                    ),
                    ActionImage(
                      type: ActionType.redo,
                      tap: (s, i) {
                        _editPerform.redo();
                      },
                    ),
                    ActionImage(
                      type: ActionType.h1,
                      tap: _disposeText,
                    ),
//                    ActionImage(
//                      type: ActionType.list,
//                      tap: _disposeText,
//                    ),
                    ActionImage(
                      type: ActionType.textQuote,
                      tap: _disposeText,
                    ),
                    ActionImage(
                      type: ActionType.link,
                      tap: _disposeText,
                    ),
                    ActionImage(
                      type: ActionType.image,
                      tap: _disposeText,
                      imageSelect: widget.imageSelect,
                    ),
                    ActionImage(
                      type: ActionType.fontBold,
                      tap: _disposeText,
                    ),
                    ActionImage(
                      type: ActionType.code,
                      tap: _disposeText,
                    ),
                    ActionImage(
                      type: ActionType.fontItalic,
                      tap: _disposeText,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
