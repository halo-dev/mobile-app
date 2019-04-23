import 'package:halo/entity_factory.dart';
import 'package:halo/net/http/http_manager.dart';

typedef void Success<T>(T cover);
typedef void Fail(int code, String msg);

///负责执行请求
const String GET = "GET";
const String POST = "POST";
const String PUT = "PUT";
const String DELETE = "DELETE";

///
void _request<T>(String url,
    {Map<String, dynamic> query,
    String method,
    Success onSuccess,
    Fail onFail,
    Function onFinish}) {
  Http.request(url, params: query, method: method, res: (response) {
    if (response.status == 200 && onSuccess != null)
      onSuccess(EntityFactory.generateOBJ<T>(response.data));
    else {
      if (onFail != null) onFail(response.status, response.message);
    }
    if (onFinish != null) onFinish();
  });
}

void ApiWithQuery<T>(String url, String method, Map<String, dynamic> query, Success onSuccess,
    Fail onFail, Function onFinish) {
  _request<T>(url,
      method: method, query: query, onSuccess: onSuccess, onFail: onFail, onFinish: onFinish);
}

void ApiRequest<T>(String url, String method, Success onSuccess, Fail onFail, Function onFinish) {
  _request<T>(url, method: method, onSuccess: onSuccess, onFail: onFail, onFinish: onFinish);
}
