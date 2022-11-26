import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;

String _generateMd5(String input) {
  return crypto.md5.convert(utf8.encode(input)).toString();
}

String _concatParams(
    {required int ts, required String privateKey, required String publicKey}) {
  return ts.toString() + privateKey + publicKey;
}

String getHash(
    {required int ts, required String privateKey, required String publicKey}) {
  return _generateMd5(
      _concatParams(ts: ts, privateKey: privateKey, publicKey: publicKey));
}
