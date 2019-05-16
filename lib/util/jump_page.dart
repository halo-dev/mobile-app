import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halo/app/base/base_widget.dart';

SlideTransition createTransition(Animation<double> animation, Widget child) {
  return new SlideTransition(
    position: new Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(animation),
    child: child,
  );
}

Future pushToNewPage(BuildContext context, Widget page) {
  return Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) {
    return page;
  }));
}

Future pushToNewPageWithWidget(BuildContext context, BaseState page) {
  return Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) {
    return BaseWidget(page);
  }));
}
