library markdown_editor;

import 'package:flutter/material.dart';
import 'package:halo/widget/markdown/action.dart';
import 'package:halo/widget/markdown/editor.dart';
import 'package:halo/widget/markdown/preview.dart';

class MarkdownText {
  const MarkdownText(this.title, this.text);

  final String title;
  final String text;

  @override
  String toString() {
    return 'MarkdownText{title: $title, text: $text}';
  }
}

enum PageType { editor, preview }

class MarkdownEditor extends StatefulWidget {
  MarkdownEditor({
    Key key,
    this.padding = const EdgeInsets.all(0.0),
    this.initTitle,
    this.initText,
    this.hintTitle,
    this.hintText,
    this.onTapLink,
    this.imageSelect,
    this.tabChange,
    this.textChange,
  }) : super(key: key);

  final EdgeInsetsGeometry padding;
  final String initTitle;
  final String initText;
  final String hintTitle;
  final String hintText;

  /// see [MdPreview.onTapLink]
  final TapLinkCallback onTapLink;

  /// see [ImageSelectCallback]
  final ImageSelectCallback imageSelect;

  /// When page change to [PageType.preview] or [PageType.editor]
  final TabChange tabChange;

  /// When title or text changed
  final VoidCallback textChange;

  @override
  State<StatefulWidget> createState() => MarkdownEditorWidgetState();
}

class MarkdownEditorWidgetState extends State<MarkdownEditor> with SingleTickerProviderStateMixin {
  final GlobalKey<MdEditorState> _editorKey = GlobalKey();
  TabController _controller;
  String _previewText = '';

  /// Get edited Markdown title and text
  MarkdownText getMarkDownText() {
    return MarkdownText(_editorKey.currentState.getTitle(), _editorKey.currentState.getText());
  }

  /// Change current [PageType]
  void setCurrentPage(PageType type) {
    _controller.index = type.index;
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: PageType.values.length);
    _controller.addListener(() {
      if (_controller.index == PageType.preview.index) {
        setState(() {
          _previewText = _editorKey.currentState.getText();
        });
      }
      if (widget.tabChange != null) {
        widget.tabChange(
            _controller.index == PageType.editor.index ? PageType.editor : PageType.preview);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: _controller,
      children: <Widget>[
        SafeArea(
          child: MdEditor(
            key: _editorKey,
            padding: widget.padding,
            initText: widget.initText,
            initTitle: widget.initTitle,
            hintText: widget.hintText,
            hintTitle: widget.hintTitle,
            imageSelect: widget.imageSelect,
            textChange: widget.textChange,
          ),
        ),
        SafeArea(
          child: MdPreview(
            text: _previewText,
            padding: widget.padding,
            onTapLink: widget.onTapLink,
          ),
        ),
      ],
    );
  }
}

typedef void TabChange(PageType type);
