import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class MdPreview extends StatefulWidget {
  MdPreview({
    Key key,
    this.text,
    this.padding = const EdgeInsets.all(0.0),
    this.onTapLink,
    this.basicStyle,
  }) : super(key: key);

  final String text;
  final EdgeInsetsGeometry padding;

  /// Custom to p, a and others basic style.
  final TextStyle basicStyle;

  /// Call this method when it tap link of markdown.
  /// If [onTapLink] is null,it will open the link with your default browser.
  final TapLinkCallback onTapLink;

  @override
  State<StatefulWidget> createState() => MdPreviewState();
}

class MdPreviewState extends State<MdPreview> {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var style =
        widget.basicStyle ?? TextStyle(fontSize: 17.0, color: Colors.black);

    return SingleChildScrollView(
      child: Padding(
        padding: widget.padding,
        child: MarkdownBody(
          data: widget.text ?? '',
          styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
            a: style.copyWith(color: Colors.blue),
            p: style,
            img: style,
            blockquote: style,
            blockquoteDecoration: new BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Colors.grey.shade300,
                  width: 5,
                ),
              ),
            ),
            blockquotePadding: 15,
          ),
          onTapLink: (href) {
            print(href);
            if (widget.onTapLink == null) {
              _launchURL(href);
            } else {
              widget.onTapLink(href);
            }
          },
        ),
      ),
    );
  }
}

typedef void TapLinkCallback(String link);
