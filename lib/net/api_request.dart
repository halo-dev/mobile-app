import 'package:halo/app/config.dart';
import 'package:halo/net/http/result_data.dart';
import 'package:rxdart/rxdart.dart';

typedef void Success<T>(T cover);
typedef void Fail(int code, String msg);
typedef void Finish();

///负责执行请求

void ApiRequest(Observable<ResultData> obs, Success onSuccess, onFail, onFinish) {
  obs
      .doOnData((response) {
        if (response.code == 0) {
//          onSuccess(response.data);
          onSuccess(response.data);
        } else {
          onFail(response.code, response.msg);
        }
      })
      .doOnDone(onFinish)
      .doOnError(() {
        print("rxDart OnError");
        onFail(Config.RXDART_UNKNOW_ERROR, "未知错误");
      })
      .listen(null);
}
