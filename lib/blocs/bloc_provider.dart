import 'package:flutter/material.dart';

abstract class BlocBase {
//  Future getData({String labelId, int page});
//
//  Future onRefresh({String labelId});
//
//  Future onLoadMore({String labelId});
//  void init();

  void dispose();
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
    this.userDispose: true,
    this.init,
  }) : super(key: key);

  final T bloc;
  final Widget child;
  final bool userDispose;
  final Function init;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends BlocBase>(BuildContext context) {
    final type = _typeOf<BlocProvider<T>>();
    BlocProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.bloc;
  }

  static Type _typeOf<T>() => T;
}

class _BlocProviderState<T> extends State<BlocProvider<BlocBase>> {
  @override
  void dispose() {
    if (widget.userDispose) widget.bloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    widget.init();
//    widget.bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
