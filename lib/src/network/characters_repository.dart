import 'package:effective_avangers/src/network/api_client.dart';

import '../models/hero_info_data.dart';

enum _MarvelApiEndpoints {
  getCharacters('v1/public/characters'),
  getExactCharacter('v1/public/characters/');

  const _MarvelApiEndpoints(this.endpoint);

  final String endpoint;
}

class CharactersRepository {
  final ApiClient apiClient;

  CharactersRepository({
    required this.apiClient,
  });

  Future<List<HeroInfoModel>> getCharacters(String eventsId) async {
    late dynamic response;
    late List<HeroInfoModel> result = [];

    try {
      response = await apiClient.dio.get(
          _MarvelApiEndpoints.getCharacters.endpoint,
          queryParameters: {'events': eventsId, 'limit': 58});
    } on Exception {
      rethrow;
    }

    final data = response.data['data'];

    for (var item in data['results']) {
      result.add(HeroInfoModel.fromJSON(item));
    }

    return result;
  }

  Future<HeroInfoModel> getExactCharacter(String characterID) async {
    late dynamic response;

    try {
      response = await apiClient.dio.get(
        _MarvelApiEndpoints.getExactCharacter.endpoint + characterID,
      );
    } on Exception {
      rethrow;
    }

    final data = response.data['data'];

    return HeroInfoModel.fromJSON(data);
  }
}
