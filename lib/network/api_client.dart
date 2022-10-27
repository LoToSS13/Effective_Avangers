import 'package:dio/dio.dart';
import 'package:effective_avangers/models/hero_info.dart';
import 'package:effective_avangers/network/marvel_api.dart';

class ApiClient {
  final _baseAPI = MarvelApi.baseApi;
  final _getCharacters = MarvelApi.getCharacters;
  final _dio = Dio();

  Future<List<HeroInfo>> getChars(
      String apiKey, String hash, String eventsId) async {
    late dynamic response;
    try {
      response = await _dio.get(_baseAPI + _getCharacters, queryParameters: {
        'apikey': apiKey,
        'hash': hash,
        'events': eventsId,
        'ts': 1,
        'limit': 50
      });
    } on Exception {
      rethrow;
    }

    final data = response.data['data'];
    List<HeroInfo> result = [];

    for (var item in data['results']) {
      result.add(HeroInfo(
          imagePath:
              item['thumbnail']['path'] + '.' + item['thumbnail']['extension'],
          name: item['name'],
          description: item['description']));
    }

    return result;
  }
}
