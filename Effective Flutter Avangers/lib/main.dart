import 'package:effective_avangers/firebase_options.dart';
import 'package:effective_avangers/src/app.dart';
import 'package:effective_avangers/src/database/hero_database.dart';
import 'package:effective_avangers/src/network/api_client.dart';
import 'package:effective_avangers/src/network/characters_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

final _publicKeyProvider = Provider((ref) => dotenv.env['PUBLIC_KEY']!);
final _privateKeyProvider = Provider((ref) => dotenv.env['PRIVATE_KEY']!);
final _baseUrlProvider = Provider((ref) => dotenv.env['BASE_URL']!);

final _dioProvider = Provider((ref) {
  final baseUrl = ref.watch(_baseUrlProvider);
  final publicKey = ref.watch(_publicKeyProvider);
  final privateKey = ref.watch(_privateKeyProvider);

  return ApiClient(
      baseUrl: baseUrl, privateKey: privateKey, publicKey: publicKey);
});

final charactersRepositoryProvider = Provider((ref) {
  ApiClient apiClient = ref.watch(_dioProvider);
  return CharactersRepository(apiClient: apiClient);
});

final heroDataBaseProvider = Provider((ref) => HeroDatabase());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await dotenv.load();
  runApp(const ProviderScope(child: App()));
}
