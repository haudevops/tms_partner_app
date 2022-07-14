import 'dart:convert';
// @Auth: cuong.nguyen
// @Description: Encrypt Util
// @Date: 09/11/2021

class EncryptUtil{

  static String encodeBase64(String data) {
    var content = utf8.encode(data);
    var digest = base64Encode(content);
    return digest;
  }

  static String decodeBase64(String data) {
    List<int> bytes = base64Decode(data);
    String result = utf8.decode(bytes);
    return result;
  }
}