import 'package:effective_avangers/src/network/api_client.dart';

import '../models/hero_info_model.dart';

const int infinityWarId = 29;

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

  Future<List<HeroInfoModel>> getCharacters() async {
    try {
      final response = await apiClient.dio.get(
          _MarvelApiEndpoints.getCharacters.endpoint,
          queryParameters: {'events': infinityWarId, 'limit': 58});
      final data = response.data['data'];
      List<HeroInfoModel> result = [];
      for (var item in data['results']) {
        result.add(HeroInfoModel.fromJSON(item));
      }
      return result;
    } on Exception {
      rethrow;
    }
  }

  Future<HeroInfoModel> getExactCharacter(int characterID) async {
    print('characterID : $characterID');
    try {
      final response = await apiClient.dio.get(
        _MarvelApiEndpoints.getExactCharacter.endpoint + characterID.toString(),
      );

      final data = response.data['data']['results'][0];
      print('data in getExactChar: $data');
      return HeroInfoModel.fromJSON(data);
    } on Exception {
      rethrow;
    }
  }
}
