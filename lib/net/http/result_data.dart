import 'dart:convert' show json;

///
///网络结果数据
///
class ResultData<T> {
  int code;
  T data;
  String msg;

  ResultData.fromParams(this.code, this.data, this.msg);

  factory ResultData(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new ResultData.fromJson(json.decode(jsonStr))
          : new ResultData.fromJson(jsonStr);

  ResultData.fromJson(jsonRes) {
    code = jsonRes['code'];
    data = jsonRes['data'];
    msg = jsonRes['msg'];
  }

  @override
  String toString() {
    return '{"code": $code,"data": ${data != null ? '${json.encode(data)}' : 'null'},"msg": ${msg != null ? '${json.encode(msg)}' : 'null'}}';
  }
}
