import 'package:flutter/material.dart';

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
}

class BaseWidget extends StatefulWidget {
  final BaseState state;

  BaseWidget(this.state);

  @override
  State<StatefulWidget> createState() => state;
}
