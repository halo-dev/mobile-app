/// 判断字符串是否为空
bool isNotEmpty(String str) {
  return null != str && str.length > 0 && str.isNotEmpty;
}

bool isEmpty(String str) {
  return null == str || str.length == 0 || str.isEmpty;
}
