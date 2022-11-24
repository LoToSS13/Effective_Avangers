import 'package:dio/dio.dart';
import 'package:effective_avangers/src/network/hash_generation.dart';

class ApiClient {
  late Dio _dio;

  Dio get dio => _dio;

  ApiClient(
      {required String baseUrl,
      required String privateKey,
      required String publicKey}) {
    final int ts = DateTime.now().millisecondsSinceEpoch;
    final String hash =
        getHash(ts: ts, privateKey: privateKey, publicKey: publicKey);

    _dio = Dio(BaseOptions(
        baseUrl: baseUrl,
        queryParameters: {'ts': ts, 'hash': hash, 'apikey': publicKey}));
  }
}
