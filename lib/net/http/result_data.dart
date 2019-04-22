import 'dart:convert' show json;

class ResultData<T> {
  int status;
  T data;
  String message;

  ResultData.fromParams(this.status, this.data, this.message);

  factory ResultData(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new ResultData.fromJson(json.decode(jsonStr))
          : new ResultData.fromJson(jsonStr);

  ResultData.fromJson(jsonRes) {
    status = jsonRes['status'];
    data = jsonRes['data'];
    message = jsonRes['message'];
  }

  @override
  String toString() {
    return '{"status": $status,"data": ${data != null ? '${json.encode(data)}' : 'null'},"message": ${message != null ? '${json.encode(message)}' : 'null'}}';
  }
}
