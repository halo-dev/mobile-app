import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halo/event/dialog_event.dart';
import 'package:halo/event/login_change_event.dart';
import 'package:halo/ui/main/main_page.dart';
import 'package:halo/util/Utils.dart';
import 'package:halo/widget/load_dialog.dart';

bool firstInit = false;

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!firstInit) {
      firstInit = true;
      onFirstInit();
    }
  }

  void onFirstInit();

  @override
  void dispose() {
    RxBus().destroy();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    RxBus().register<DialogChangeEvent>().listen((event) {
      if (event.show && !showLoading) {
        dialogShow(context, event.msg);
      }

      if (showLoading && !event.show) {
        showLoading = false;
        Navigator.of(context).pop();
      }
    });
    RxBus().register<LoginChangeEvent>().listen((event) {
      Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (BuildContext context) {
        return MainPage();
      }), (Route<dynamic> route) => false);
    });
  }

  var showLoading = false;

  void dialogShow(BuildContext context, String msg) async {
    Log("showLoading");
    showLoading = true;
    showLoading = await showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog(
            text: msg,
          );
        });
  }
}

class BaseWidget extends StatefulWidget {
  final BaseState state;

  BaseWidget(this.state);

  @override
  State<StatefulWidget> createState() => state;
}
