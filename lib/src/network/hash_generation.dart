import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;

String _generateMd5(String input) {
  return crypto.md5.convert(utf8.encode(input)).toString();
}

String _concatParams(int ts, String privateKey, String publicKey) {
  return ts.toString() + publicKey + privateKey;
}

String getHash(
    {required int ts, required String privateKey, required String publicKey}) {
  return _generateMd5(_concatParams(ts, privateKey, publicKey));
}
