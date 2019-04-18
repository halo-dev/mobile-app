import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PreviewMarkdown extends StatelessWidget {
  String title;
  String markdown;
  String type;

  PreviewMarkdown(this.title, this.markdown, this.type);

  static TextTheme textTheme = new Typography(platform: TargetPlatform.android)
      .black
      .merge(new TextTheme(body1: new TextStyle(fontSize: 16.0)));
  static final ThemeData theme = new ThemeData.light().copyWith(textTheme: textTheme);

  final MarkdownStyleSheet style1 = new MarkdownStyleSheet.fromTheme(theme);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Markdown(
          data: markdown,
          styleSheet: style1,
        ));
  }
}
