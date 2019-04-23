import 'package:flutter/material.dart';
import 'package:halo/widget/login_text_field.dart';

typedef onDone(String field1, String field2);

class TextFieldDialog {
  BuildContext context;
  String title;
  onDone done;

  TextFieldDialog(this.context, this.title, this.done) {
    _showTextFieldDialog();
  }

  final TextEditingController _nameCtl = new TextEditingController();
  final TextEditingController _singeCtl = new TextEditingController();

  void _showTextFieldDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(24.0, 0, 24.0, 0),
          title: Text(title),
          content: SizedBox(
            child: Column(
              children: [
                loginTextField("Tag Name", _nameCtl, null, action: TextInputAction.next),
                loginTextField("Slug Name", _singeCtl, null, inputType: TextInputType.url)
              ],
            ),
            height: 120,
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("取消"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            new FlatButton(
              child: new Text("确定"),
              onPressed: () {
                done(_nameCtl.text, _singeCtl.text);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
