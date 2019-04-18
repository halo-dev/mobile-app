import 'dart:collection';

class RequestInfo {
  String _HOST = "";
  HashMap<String, String> _params = HashMap();

  HashMap<String, String> get params => _params;

  String get HOST => _HOST;
}
