import 'package:halo/net/http/http_manager.dart';
import 'package:halo/net/http/result_data.dart';
import 'package:rxdart/rxdart.dart';

const String BaseUrl = "http://www.apkdv.com";

class Api {
  
  Observable<ResultData> getPosts({Map<String, dynamic> query}) =>
      Observable.fromFuture(Http.get("/api/admin/posts", query: query));
}
