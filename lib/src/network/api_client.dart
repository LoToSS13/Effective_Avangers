import 'package:dio/dio.dart';
import 'package:effective_avangers/src/network/hash_generation.dart';

class ApiClient implements Interceptor {
  final String _privateKey;
  final String _publicKey;
  late Dio _dio;

  Dio get dio => _dio;

  ApiClient(
      {required String baseUrl,
      required String privateKey,
      required String publicKey})
      : _privateKey = privateKey,
        _publicKey = publicKey {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
    ))
      ..interceptors.add(this);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final int ts = DateTime.now().millisecondsSinceEpoch;
    final String hash =
        getHash(ts: ts, privateKey: _privateKey, publicKey: _publicKey);
    options.queryParameters
        .addAll({'ts': ts, 'apikey': _publicKey, 'hash': hash});
    print(ts);
    print(_publicKey);
    print(hash);
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }
}
