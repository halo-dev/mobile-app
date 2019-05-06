import 'package:rxdart/rxdart.dart';

class Bus {
  PublishSubject _Subject;

  PublishSubject get subject => _Subject;

  Bus() {
    _Subject = PublishSubject();
  }
}

class RxBus {
  static final RxBus _singleton = new RxBus._internal();

  factory RxBus() {
    return _singleton;
  }

  RxBus._internal();

  static List<Bus> _list = List();

  /// 监听事件。每次监听开启都会新建一个[PublishSubject] 防止重复监听事件
  Observable<T> register<T>() {
    Bus _eventBus;
    //已经注册过的tag不需要重新注册
    if (_eventBus == null) {
      _eventBus = Bus();
      _list.add(_eventBus);
    }
    if (T == dynamic) {
      _eventBus.subject.stream;
    } else {
      return _eventBus.subject.stream.where((event) => event is T).cast<T>();
    }
  }

  ///发送事件
  void post(event) {
    _list.forEach((rxBus) {
      rxBus.subject.sink.add(event);
    });
  }

  ///事件关闭
  void destroy() {
    var toRemove = [];
    _list.forEach((rxBus) {
      rxBus.subject.close();
      toRemove.add(rxBus);
    });
    _list.removeWhere((e) => toRemove.contains(e));
  }
}
