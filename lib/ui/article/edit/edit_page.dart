import 'package:flutter/material.dart';
import 'package:halo/widget/markdown/markdown_editor.dart';

const String _markdownData = """# Markdown Example
Markdown allows you to easily include formatted text, images, and even formatted Dart code in your app.
## Styling
Style text as _italic_, __bold__, or `inline code`.
- Use bulleted lists
- To better clarify
- Your points
## Links
You can use [hyperlinks](hyperlink) in markdown
## Images
You can include images:
![Flutter logo](https://flutter.io/images/flutter-mark-square-100.png#100x100)
## Markdown widget
This is an example of how to create your own Markdown widget:
    new Markdown(data: 'Hello _world_!');
## Code blocks
Formatted Dart code looks really pretty too:
```
void main() {
  runApp(new MaterialApp(
    home: new Scaffold(
      body: new Markdown(data: markdownData)
    )
  ));
}
```
Enjoy!
""";

class EditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Color.fromARGB(255, 0, 135, 190),
          title: Text("纂写文章"),
          centerTitle: Theme.of(context).platform == TargetPlatform.iOS ? true : false,
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  _preview(context);
                },
                child: Text(
                  "下一步",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                )),
          ],
        ),
        body: MarkdownEditor(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
          initTitle: "标题",
          initText: _markdownData,
        ));
  }

  get textStyle => TextStyle(
      fontSize: 18.0, height: 1.3, textBaseline: TextBaseline.alphabetic, color: Colors.black);

  get highlightedTextStyle => TextStyle(
      fontSize: 18.0, height: 1.3, textBaseline: TextBaseline.alphabetic, color: Colors.lightBlue);

  void _preview(BuildContext context) {
//    controller.controller.clear();
//    print(controller.controller.text);
//    controller.triggerSave();
//    pushToNewPage(context, PreviewMarkdown("新文章", controller.controller.text, "new"));
  }
}
