import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main.dart';
import '../app.dart';
import '../constant/main_navigation_route_name.dart';
import '../models/hero_info_args.dart';
import 'characters_repository.dart';

class PushNotificationService {
  static Future initialise(WidgetRef ref) async {
    Future<void> messageHandler(RemoteMessage? message,
        CharactersRepository charactersRepository) async {
      if (message != null) {
        final int characterID = int.parse(message.data['character_id']);

        final characterInfo =
            await charactersRepository.getExactCharacter(characterID);
        navigatorKey.currentState?.pushNamed(MainNavigationRouteName.detailed,
            arguments: HeroInfoArgs(heroInfo: characterInfo));
      }
    }

    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    late CharactersRepository charactersRepository =
        ref.watch(charactersRepositoryProvider);

    FirebaseMessaging.onMessage.listen(
      (event) {
        messageHandler(event, charactersRepository);
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen(((event) {
      messageHandler(event, charactersRepository);
    }));
    if (initialMessage != null) {
      messageHandler(initialMessage, charactersRepository);
    }
  }
}
