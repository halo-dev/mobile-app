import 'package:flutter/material.dart';
import 'package:halo/app/provide.dart';
import 'package:halo/module/post_param.dart';
import 'package:halo/ui/post/edit/edit_post_module.dart';
import 'package:halo/ui/post/edit/set_post_option.dart';
import 'package:halo/util/Utils.dart';
import 'package:halo/widget/markdown/markdown_editor.dart';

class EditPostPage extends StatelessWidget {
  bool _isEdit = false;
  PostParam _param;

  EditPostPage(this._isEdit, this._param);

  GlobalKey<MarkdownEditorWidgetState> Mykey = GlobalKey<MarkdownEditorWidgetState>();

  @override
  Widget build(BuildContext context) {
    Provide.value<EditPostModule>(context).setPostParam(_param);
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Color.fromARGB(255, 0, 135, 190),
          title: Text("纂写文章"),
//          centerTitle: Theme.of(context).platform == TargetPlatform.iOS ? true : false,
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  _setOption(context);
                },
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 25,
                )),
            IconButton(
                onPressed: () {
                  _send(context);
                },
                icon: Image.asset(
                  "assest/images/post.png",
                  color: Colors.white,
                  width: 25,
                  height: 25,
                )),
          ],
        ),
        body: Provide<EditPostModule>(builder: (context, child, mode) {
          return MarkdownEditor(
            key: Mykey,
            padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
            initTitle: mode.getTitle(),
            initText: mode.getContent(),
          );
        }));
  }

  get textStyle => TextStyle(
      fontSize: 18.0, height: 1.3, textBaseline: TextBaseline.alphabetic, color: Colors.black);

  get highlightedTextStyle => TextStyle(
      fontSize: 18.0, height: 1.3, textBaseline: TextBaseline.alphabetic, color: Colors.lightBlue);

  _send(BuildContext context) {
    print(Mykey.currentState.getMarkDownText().toString());
  }

  _setOption(BuildContext context) {
    Provide.value<EditPostModule>(context).saveParam(Mykey.currentState.getMarkDownText());
    pushToNewPage(context, SetPostOptionPage());
  }
}
