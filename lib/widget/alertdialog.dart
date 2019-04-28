import 'package:flutter/material.dart';

class AlertContentDialog {
  BuildContext context;
  String title;
  Function done;
  Widget child;

  AlertContentDialog(this.context, this.title, this.done, this.child) {
    _showDialog();
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(24.0, 0, 24.0, 0),
          title: Text(title),
          content: child,
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
                if (done != null) {
                  done();
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
