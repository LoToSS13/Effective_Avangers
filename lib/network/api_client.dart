import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;
import 'package:dio/dio.dart';
import 'package:effective_avangers/models/hero_info_data.dart';
import 'package:effective_avangers/network/marvel_api.dart';

class ApiClient {
  final _baseAPI = MarvelApi.baseApi;
  final _getCharacters = MarvelApi.getCharacters;
  final _dio = Dio();
  final ts = DateTime.now().microsecondsSinceEpoch;
  final limit = 58;

  Future<List<HeroInfoModel>> getChars(
      String publicKey, String privateKey, String eventsId) async {
    late dynamic response;
    final String stringToHash =
        concatParams(ts: ts, privateKey: privateKey, publicKey: publicKey);
    final hash = generateMd5(stringToHash);
    try {
      response = await _dio.get(_baseAPI + _getCharacters, queryParameters: {
        'apikey': publicKey,
        'hash': hash,
        'events': eventsId,
        'ts': ts,
        'limit': limit
      });
    } on Exception {
      rethrow;
    }

    final data = response.data['data'];
    List<HeroInfoModel> result = [];

    for (var item in data['results']) {
      result.add(HeroInfoModel.fromJSON(item));
    }

    return result;
  }
}

String generateMd5(String input) {
  return crypto.md5.convert(utf8.encode(input)).toString();
}

String concatParams(
    {required int ts, required String privateKey, required String publicKey}) {
  return ts.toString() + publicKey + privateKey;
}
