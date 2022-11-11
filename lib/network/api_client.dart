import 'package:dio/dio.dart';
import 'package:effective_avangers/models/hero_info_data.dart';
import 'package:effective_avangers/network/marvel_api.dart';

class ApiClient {
  final _baseAPI = MarvelApi.baseApi;
  final _getCharacters = MarvelApi.getCharacters;
  final _dio = Dio();
  final ts = 1;
  final limit = 58;

  Future<List<HeroInfoModel>> getChars(
      String apiKey, String hash, String eventsId) async {
    late dynamic response;
    try {
      response = await _dio.get(_baseAPI + _getCharacters, queryParameters: {
        'apikey': apiKey,
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
