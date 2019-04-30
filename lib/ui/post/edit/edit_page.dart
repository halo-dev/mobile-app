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
    return WillPopScope(
      child: Scaffold(
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
          })),
      onWillPop: () {
        _onBackNotSave(context);
      },
    );
  }

  get textStyle => TextStyle(
      fontSize: 18.0, height: 1.3, textBaseline: TextBaseline.alphabetic, color: Colors.black);

  get highlightedTextStyle => TextStyle(
      fontSize: 18.0, height: 1.3, textBaseline: TextBaseline.alphabetic, color: Colors.lightBlue);

  _send(BuildContext context) {
    Provide.value<EditPostModule>(context).saveParam(Mykey.currentState.getMarkDownText());
    Provide.value<EditPostModule>(context).send(context);
  }

  _setOption(BuildContext context) {
    Provide.value<EditPostModule>(context).saveParam(Mykey.currentState.getMarkDownText());
    pushToNewPage(context, SetPostOptionPage());
  }

  bool _onBackNotSave(BuildContext context) {
    ///保存正在编辑的内容
    Provide.value<EditPostModule>(context).saveParam(Mykey.currentState.getMarkDownText());
    //比较
    var chenaged = Provide.value<EditPostModule>(context).onBackNotSave();
    if (!chenaged) {
      _buildDialog(context, "当前文章已经改变，但还没有发布，是否放弃编辑。", () {
        exitEdit(context);
      }, () {
        _send(context);
      });
    } else if (Provide.value<EditPostModule>(context).hasChanged()) {
      _buildDialog(context, "当前文章还没有发布，是否放弃编辑。", () {
        exitEdit(context);
      }, () {
        _send(context);
      });
    } else {
      exitEdit(context);
    }
  }

  void exitEdit(BuildContext context) {
    Provide.value<EditPostModule>(context).cleanData();
    Navigator.pop(context);
  }

  _buildDialog(BuildContext context, content, giveUp, onSend) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(24.0, 0, 24.0, 0),
            title: Text("确定退出"),
            content: Text(content),
            actions: <Widget>[
              new FlatButton(
                child: new Text("放弃"),
                onPressed: () {
                  exitEdit(context);
                  giveUp();
                },
              ),
              new FlatButton(
                child: new Text("发布"),
                onPressed: () {
                  exitEdit(context);
                  onSend();
                },
              ),
            ],
          );
        });
  }
}
